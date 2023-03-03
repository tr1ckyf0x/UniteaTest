//
//  UTestApp.swift
//  UTest
//
//  Created by Vladislav Lisianskii on 05.03.2023.
//  Copyright © 2023 Vladislav Lisianskii. All rights reserved.
//

import SwiftUI

@main
struct SwiftUITestApp: App {
    var body: some Scene {
        WindowGroup {
            TrackListView(viewModel: TrackListView.ViewModel())
        }
    }
}
