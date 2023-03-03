//
//  QueryStringRequestModificatorTests.swift
//  
//
//  Created by Vladislav Lisianskii on 04.03.2023.
//

@testable import APIClient
import XCTest

final class QueryStringRequestModificatorTests: XCTestCase {

    func testQueryParametersEncoding() {
        // given
        let parameters: [String: Any] = [
            "arrayValue": [1, 2, 3],
            "boolValue": true,
            "dictionaryValue": [
                "ping": "pong",
                "SYN": "ACK"
            ],
            "doubleValue": 12.13,
            "intValue": 42,
            "stringValue": "fooBar"
        ]
        // swiftlint:disable:next line_length
        let expected = "arrayValue%255B%255D=1&arrayValue%255B%255D=2&arrayValue%255B%255D=3&boolValue=1&dictionaryValue%255BSYN%255D=ACK&dictionaryValue%255Bping%255D=pong&doubleValue=12.13&intValue=42&stringValue=fooBar"
        var urlRequest = URLRequest(url: URL(string: "https://test.com")!)
        let modificator = QueryStringRequestModificator(parameters: parameters)
        // when
        modificator.modify(&urlRequest)
        // then
        let result = urlRequest.url?.query()
        XCTAssertEqual(result, expected, "Modificator must generate valid query string")
    }
}
