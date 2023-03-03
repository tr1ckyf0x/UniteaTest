//
//  TrackListView.swift
//  UTest
//
//  Created by Vladislav Lisianskii on 05.03.2023.
//  Copyright © 2023 Vladislav Lisianskii. All rights reserved.
//

import ITunesAPI
import SwiftUI

struct TrackListView: View {

    @StateObject var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            if viewModel.tracks.isEmpty {
                Text(L10n.SongList.State.Empty.text)
            } else {
                List(viewModel.tracks) { track in
                    TrackView(
                        title: track.name,
                        subtitle: track.artist,
                        imageURL: track.artworkURL,
                        isPlaying: viewModel.playingTrack == track
                    )
                    .onTapGesture {
                        viewModel.didSelectTrack(track)
                    }
                }
            }
        }
        .searchable(text: $viewModel.searchText)
    }
}

// swiftlint:disable line_length
struct TrackListView_Previews: PreviewProvider {
    static var previews: some View {

        let tracks = [
            TrackSearchItem(
                trackID: 0,
                name: "Home",
                artist: "Three Days Grace",
                artworkURL: URL(string: "https://is2-ssl.mzstatic.com/image/thumb/Features125/v4/6b/67/1f/6b671f4f-106b-9a41-e297-68ab4a492a16/dj.dztjnlku.jpg/60x60bb.jpg")!,
                previewURL: URL(string: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview122/v4/32/8f/44/328f4491-72bc-1c0e-f9ca-30b2f7574aea/mzaf_14701996440918143901.plus.aac.p.m4a")!
            ),
            TrackSearchItem(
                trackID: 123,
                name: "California Dreamin'",
                artist: "The Mamas & The Papas",
                artworkURL: URL(string: "https://is5-ssl.mzstatic.com/image/thumb/Music122/v4/91/c0/fe/91c0fecf-6ff3-880d-2b4a-31e38c285b25/06UMGIM04098.rgb.jpg/60x60bb.jpg")!,
                previewURL: URL(string: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview122/v4/ed/6d/3d/ed6d3d6a-9fae-ceac-9fb9-cdd8dad36795/mzaf_2261212329196374154.plus.aac.p.m4a")!
            )
        ]

        Group {
            TrackListView(viewModel: TrackListView.ViewModel(tracks: tracks))
            TrackListView(viewModel: TrackListView.ViewModel())
        }
    }
}
