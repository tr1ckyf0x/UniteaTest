//
//  ITunesTarget.swift
//  UTest
//
//  Created by Vladislav Lisianskii on 04.03.2023.
//  Copyright © 2023 Vladislav Lisianskii. All rights reserved.
//

import APIClient
import Foundation

public enum ITunesTarget {
    case search(term: String)
}

// MARK: - Target
extension ITunesTarget: Target {
    public var baseURL: URL {
        URL(string: "https://itunes.apple.com")!
    }

    public var path: String {
        switch self {
        case .search:
            return "search"
        }
    }

    public var method: APIClient.HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }

    public var task: APIClient.Task {
        switch self {
        case let .search(term):
            return .queryRequest(parameters: ["term": term])
        }
    }
}
