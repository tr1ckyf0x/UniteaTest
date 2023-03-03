//
//  Request.swift
//  
//
//  Created by Vladislav Lisianskii on 04.03.2023.
//

import Foundation

public class Request {

    // MARK: - Properties
    var task: URLSessionTask?
    let urlRequest: URLRequest
    fileprivate let target: Target
    fileprivate var responseProcessor: ProcessesRawResponse?

    // MARK: - Initialization
    init(
        target: Target,
        urlRequestBuilder: BuildsURLRequest = URLRequestBuilder()
    ) {
        self.target = target
        self.urlRequest = urlRequestBuilder.buildURLRequest(from: target)
    }
}

// MARK: - Resumeable, Cancellable
extension Request: Resumeable, Cancellable {
    public func resume() {
        task?.resume()
    }

    public func cancel() {
        task?.cancel()
    }
}

// MARK: - DataRequest
public class DataRequest: Request {

    // MARK: - Public
    public func responseDecodable<T: Decodable>(
        of type: T.Type,
        decoder: JSONDecoder = JSONDecoder(),
        completionQueue: DispatchQueue = .main,
        completion: ((Result<T, Error>) -> Void)?
    ) -> Self {
        responseProcessor = DecodableProcessor<T>(
            decoder: decoder,
            completionQueue: completionQueue,
            completion: completion
        )
        return self
    }
}

extension DataRequest {
    func didReceiveResponse(data: Data?, response: URLResponse?, error: Error?) {
        let result: Result<Data, Error>
        switch (data, error) {
        case let (.some(data), .none):
            result = .success(data)

        case let (.none, .some(error)):
            result = .failure(error)

        default:
            result = .failure(APIError.unexpectedError)
        }
        responseProcessor?.process(result)
    }
}
