//
//  QueryStringRequestModificator.swift
//  
//
//  Created by Vladislav Lisianskii on 04.03.2023.
//

import Foundation

public struct QueryStringRequestModificator: ModifiesRequest {

    // MARK: - Properties
    private let parameters: Parameters
    private let arrayEncoding: ArrayEncoding
    private let boolEncoding: BoolEncoding

    // MARK: - Initialization
    public init(
        parameters: Parameters,
        arrayEncoding: ArrayEncoding = .brackets,
        boolEncoding: BoolEncoding = .numeric
    ) {
        self.parameters = parameters
        self.arrayEncoding = arrayEncoding
        self.boolEncoding = boolEncoding
    }

    // MARK: - Public
    public func modify(_ request: inout URLRequest) {
        let queryItems = makeQueryItems(parameters)
        request.url?.append(queryItems: queryItems)
    }

    // MARK: - Private
    private func makeQueryItems(_ parameters: Parameters) -> [URLQueryItem] {
        parameters
            .keys
            .lazy
            .sorted(by: <) // Sort is required for identical results in tests
            .flatMap { key -> [(String, String)] in
                guard let value = parameters[key] else { return [] }
                return queryComponents(fromKey: key, value: value)
            }
            .map(URLQueryItem.init(name:value:))
    }

    private func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        switch value {
        case let dictionary as [String: Any]:
            return dictionary.flatMap { (nestedKey: String, value: Any) in
                queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
            }

        case let array as [Any]:
            return array.flatMap { (value: Any) in
                queryComponents(fromKey: arrayEncoding.encode(key: key), value: value)
            }

        case let bool as Bool:
            return [(escape(key), escape(boolEncoding.encode(value: bool)))]

        default:
            return [(escape(key), escape("\(value)"))]
        }
    }

    private func escape(_ string: String) -> String {
        // TODO: Causes wrong escaping. URLRequest escapes symbols by itself
//        string.addingPercentEncoding(withAllowedCharacters: .queryAllowed) ?? string
        string
    }
}

// MARK: - Encoding
extension QueryStringRequestModificator {
    public enum ArrayEncoding {
        case brackets

        func encode(key: String) -> String {
            switch self {
            case .brackets:
                return "\(key)[]"
            }
        }
    }

    public enum BoolEncoding {
        case numeric

        func encode(value: Bool) -> String {
            switch self {
            case .numeric:
                return value ? "1" : "0"
            }
        }
    }
}

// MARK: - CharacterSet + Querry allowed
extension CharacterSet {
    fileprivate static let queryAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="
        let encodableDelimiters = CharacterSet(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")

        return CharacterSet.urlQueryAllowed.subtracting(encodableDelimiters)
    }()
}
