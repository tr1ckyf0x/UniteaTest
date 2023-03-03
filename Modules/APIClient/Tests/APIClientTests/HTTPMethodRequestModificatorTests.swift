//
//  HTTPMethodRequestModificatorTests.swift
//  
//
//  Created by Vladislav Lisianskii on 04.03.2023.
//

@testable import APIClient
import XCTest

final class HTTPMethodRequestModificatorTests: XCTestCase {

    // TODO: Check with other HTTPMethod, as GET is set by default
    func testHTTPMethodSet() {
        // given
        var urlRequest = URLRequest(url: URL(string: "https://test.com")!)
        let modificator = HTTPMethodRequestModificator(httpMethod: .get)
        // when
        modificator.modify(&urlRequest)
        // then
        XCTAssertEqual(urlRequest.httpMethod, "GET")
    }
}
