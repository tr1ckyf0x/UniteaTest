//
//  SearchItem.swift
//  UTest
//
//  Created by Vladislav Lisianskii on 04.03.2023.
//  Copyright © 2023 Vladislav Lisianskii. All rights reserved.
//

import Foundation

public enum SearchItem: Decodable {
    case track(TrackSearchItem)
    case unsupported // Also possible type is audiobook, which in our case is not interesting for pirates

    private enum WrapperCodingKeys: String, CodingKey {
        case wrapperType
    }

    private enum WrapperType: String, Decodable {
        case track
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: WrapperCodingKeys.self)
        let type = try? container.decode(WrapperType.self, forKey: .wrapperType)

        switch type {
        case .track:
            let track = try decoder.singleValueContainer().decode(TrackSearchItem.self)
            self = .track(track)

        case .none:
            self = .unsupported
        }
    }
}

public struct TrackSearchItem: Decodable, Identifiable, Equatable {
    public var id: Int {
        trackID
    }

    public let trackID: Int
    public let name: String
    public let artist: String
    public let artworkURL: URL
    public let previewURL: URL

    public init(
        trackID: Int,
        name: String,
        artist: String,
        artworkURL: URL,
        previewURL: URL
    ) {
        self.trackID = trackID
        self.name = name
        self.artist = artist
        self.artworkURL = artworkURL
        self.previewURL = previewURL
    }

    enum CodingKeys: String, CodingKey {
        case trackID = "trackId"
        case name = "trackName"
        case artist = "artistName"
        case artworkURL = "artworkUrl60"
        case previewURL = "previewUrl"
    }
}
