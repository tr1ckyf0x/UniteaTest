//
//  DecoratesRequest.swift
//  
//
//  Created by Vladislav Lisianskii on 03.03.2023.
//

import Foundation

public protocol DecoratesRequest: ModifiesRequest, AnyObject {
    var modificator: ModifiesRequest { get }
    var next: DecoratesRequest? { get set }
}

public final class RequestDecorator: DecoratesRequest {

    // MARK: - Properties
    public let modificator: ModifiesRequest
    public var next: DecoratesRequest?

    // MARK: - Initialization
    public init(
        modificator: ModifiesRequest,
        next: DecoratesRequest? = nil
    ) {
        self.modificator = modificator
        self.next = next
    }

    // MARK: - Public
    public func modify(_ request: inout URLRequest) {
        modificator.modify(&request)
        next?.modify(&request)
    }
}
