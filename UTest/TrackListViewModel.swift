//
//  TrackListViewModel.swift
//  UTest
//
//  Created by Vladislav Lisianskii on 05.03.2023.
//  Copyright © 2023 Vladislav Lisianskii. All rights reserved.
//

import APIClient
import Foundation
import ITunesAPI
import StreamPlayer

extension TrackListView {
    final class ViewModel: ObservableObject {

        // MARK: - Properties
        @Published var searchText = "" {
            didSet {
                searchTextDidUpdate()
            }
        }
        @Published private(set) var tracks: [TrackSearchItem] = []
        @Published private(set) var playingTrack: TrackSearchItem?

        private var activeRequest: (Cancellable & Resumeable)?

        private let session: SessionProtocol
        private let debouncer: DebouncerProtocol
        private var player: PlaysStreamAudio?

        // MARK: - Initialization
        init(
            session: SessionProtocol = Session(),
            debouncer: DebouncerProtocol = Debouncer(timeInterval: Constants.debounceInterval)
        ) {
            self.session = session
            self.debouncer = debouncer
        }

        #if DEBUG
        convenience init(
            tracks: [TrackSearchItem],
            session: SessionProtocol = Session()
        ) {
            self.init(session: session)
            self.tracks = tracks
        }
        #endif

        // MARK: - Public
        func didSelectTrack(_ track: TrackSearchItem) {
            let isSameTrack = playingTrack == track
            if playingTrack != nil {
                player?.pause()
                self.playingTrack = nil
                player = nil
            }
            if isSameTrack { return }

            playingTrack = track
            player = StreamPlayer(url: track.previewURL)
            player?.play()
        }

        // MARK: - Private
        private func searchTextDidUpdate() {
            guard searchText.count >= Constants.minimumSearchRequestLength else {
                purgeTracks()
                return
            }
            debouncer.renewInterval()
            debouncer.handler = { [weak self] in
                self?.fetchTracks()
            }
        }

        private func fetchTracks() {
            activeRequest?.cancel()
            activeRequest = session.makeRequest(ITunesTarget.search(term: searchText))
                .responseDecodable(of: SearchResponse.self) { [weak self] (result: Result<SearchResponse, Error>) in
                    self?.activeRequest = nil
                    switch result {
                    case let .success(response):
                        self?.tracks = response.results.compactMap { (item: SearchItem) -> TrackSearchItem? in
                            guard case let .track(trackSearchItem) = item else {
                                return nil
                            }
                            return trackSearchItem
                        }

                    case .failure:
                        self?.purgeTracks()
                    }
                }
            activeRequest?.resume()
        }

        private func purgeTracks() {
            tracks = []
        }
    }
}

extension TrackListView.ViewModel {
    private enum Constants {
        static let debounceInterval: TimeInterval = 0.3
        static let minimumSearchRequestLength = 3
    }
}
