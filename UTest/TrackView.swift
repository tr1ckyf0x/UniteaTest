//
//  TrackView.swift
//  UTest
//
//  Created by Vladislav Lisianskii on 05.03.2023.
//  Copyright © 2023 Vladislav Lisianskii. All rights reserved.
//

import SwiftUI

struct TrackView: View {

    let title: String
    let subtitle: String
    let imageURL: URL
    let isPlaying: Bool

    var body: some View {
        HStack {
            ZStack {
                AsyncImage(url: imageURL)
                if isPlaying {
                    PlaybackControlOverlayView()
                }
            }
            .frame(width: 60, height: 60)
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.body)
            }
        }
    }
}

// swiftlint:disable line_length
struct TrackView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TrackView(
                title: "Home",
                subtitle: "Three Days Grace",
                imageURL: URL(string: "https://is2-ssl.mzstatic.com/image/thumb/Features125/v4/6b/67/1f/6b671f4f-106b-9a41-e297-68ab4a492a16/dj.dztjnlku.jpg/60x60bb.jpg")!,
                isPlaying: false
            )

            TrackView(
                title: "Home",
                subtitle: "Three Days Grace",
                imageURL: URL(string: "https://is2-ssl.mzstatic.com/image/thumb/Features125/v4/6b/67/1f/6b671f4f-106b-9a41-e297-68ab4a492a16/dj.dztjnlku.jpg/60x60bb.jpg")!,
                isPlaying: true
            )
        }
    }
}
