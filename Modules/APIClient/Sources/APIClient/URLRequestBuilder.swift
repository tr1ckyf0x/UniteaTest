//
//  URLRequestBuilder.swift
//  
//
//  Created by Vladislav Lisianskii on 03.03.2023.
//

import Foundation

public protocol BuildsURLRequest {
    func buildURLRequest(from target: Target) -> URLRequest
}

public struct URLRequestBuilder: BuildsURLRequest {

    public init() { }

    // MARK: - Public
    public func buildURLRequest(from target: Target) -> URLRequest {
        let url = buildURL(from: target)
        var request = URLRequest(url: url)
        let decorator = RequestDecoratorFactory().requestDecorator(for: target)
        decorator.modify(&request)
        return request
    }

    // MARK: - Private
    private func buildURL(from target: Target) -> URL {
        let targetPath = target.path

        // swiftlint:disable:next line_length
        // When a Target's path is empty, URL.appendingPathComponent may introduce trailing /, which may not be wanted in some cases
        if targetPath.isEmpty {
            return target.baseURL
        } else {
            return target.baseURL.appendingPathComponent(targetPath)
        }
    }
}
