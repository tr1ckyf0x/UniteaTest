//
//  PlaybackControlOverlayView.swift
//  UTest
//
//  Created by Vladislav Lisianskii on 06.03.2023.
//  Copyright © 2023 Vladislav Lisianskii. All rights reserved.
//

import SwiftUI

struct PlaybackControlOverlayView: View {

    var body: some View {
        ZStack {
            Rectangle()
                .opacity(0.5)
            Image(systemName: "pause.fill")
        }
    }
}

struct PlaybackControlOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlaybackControlOverlayView()
            .frame(width: 60, height: 60)
    }
}
