//
//  ResponseProcessor.swift
//  
//
//  Created by Vladislav Lisianskii on 05.03.2023.
//

import Foundation

protocol ProcessesRawResponse {
    func process(_ result: Result<Data, Error>)
}

final class DecodableProcessor<T: Decodable>: ProcessesRawResponse {

    // MARK: - Properties
    private let decoder: JSONDecoder
    private let completionQueue: DispatchQueue
    private let completion: ((Result<T, Error>) -> Void)?

    // MARK: - Initialization
    init(
        decoder: JSONDecoder,
        completionQueue: DispatchQueue,
        completion: ((Result<T, Error>) -> Void)?
    ) {
        self.decoder = decoder
        self.completionQueue = completionQueue
        self.completion = completion
    }

    // MARK: - Public
    func process(_ result: Result<Data, Error>) {
        var processedResult: Result<T, Error>

        defer {
            completionQueue.async { [weak self] in
                self?.completion?(processedResult)
            }
        }

        switch result {
        case let .success(data):
            do {
                let responseObject = try decoder.decode(T.self, from: data)
                processedResult = .success(responseObject)
            } catch {
                processedResult = .failure(APIError.decodeError)
            }

        case let .failure(error):
            processedResult = .failure(error)
        }
    }
}
