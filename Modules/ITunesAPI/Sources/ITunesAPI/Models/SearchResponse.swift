//
//  SearchResponse.swift
//  UTest
//
//  Created by Vladislav Lisianskii on 04.03.2023.
//  Copyright © 2023 Vladislav Lisianskii. All rights reserved.
//

import Foundation

public struct SearchResponse: Decodable {
    public let results: [SearchItem]
}
