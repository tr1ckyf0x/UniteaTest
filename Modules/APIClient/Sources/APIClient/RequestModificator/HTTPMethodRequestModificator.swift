//
//  HTTPMethodRequestModificator.swift
//  
//
//  Created by Vladislav Lisianskii on 04.03.2023.
//

import Foundation

public struct HTTPMethodRequestModificator: ModifiesRequest {

    // MARK: - Properties
    private let httpMethod: HTTPMethod

    // MARK: - Initialization
    public init(
        httpMethod: HTTPMethod
    ) {
        self.httpMethod = httpMethod
    }

    // MARK: - Public
    public func modify(_ request: inout URLRequest) {
        request.httpMethod = httpMethod.rawValue
    }
}
