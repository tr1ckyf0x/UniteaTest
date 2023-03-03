//
//  Session.swift
//  
//
//  Created by Vladislav Lisianskii on 03.03.2023.
//

import Foundation

public protocol SessionProtocol {
    func makeRequest(_ target: Target) -> DataRequest
}

public final class Session {
    private let urlSession: URLSession

    public init(
        urlSession: URLSession = .shared
    ) {
        self.urlSession = urlSession
    }
}

// MARK: - SessionProtocol
extension Session: SessionProtocol {
    public func makeRequest(_ target: Target) -> DataRequest {
        let dataRequest = DataRequest(target: target)
        let dataTask = urlSession.dataTask(with: dataRequest.urlRequest) { data, response, error in
            // TODO: Refactor using URLSessionDataDelegate
            dataRequest.didReceiveResponse(data: data, response: response, error: error)
        }
        dataRequest.task = dataTask
        return dataRequest
    }
}
