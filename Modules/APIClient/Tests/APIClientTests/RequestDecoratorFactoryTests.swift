//
//  RequestDecoratorFactoryTests.swift
//  
//
//  Created by Vladislav Lisianskii on 04.03.2023.
//

@testable import APIClient
import XCTest

final class RequestDecoratorFactoryTests: XCTestCase {

    private var requestDecoratorFactory: RequestDecoratorFactory!

    override func setUp() {
        super.setUp()
        requestDecoratorFactory = RequestDecoratorFactory()
    }

    func testQueryStringTaskDecoratorsOrder() {
        // given
        let target = TestData.queryStringTestTarget
        // when
        let decorator = requestDecoratorFactory.requestDecorator(for: target)
        // then
        XCTAssertTrue(decorator.modificator is HTTPMethodRequestModificator)
        XCTAssertTrue(decorator.next?.modificator is QueryStringRequestModificator)
    }
}

private enum TestData {
    static let queryStringTestTarget = TestTarget(
        baseURL: URL(string: "https://test.com")!,
        path: "v1/request",
        method: .get,
        task: .queryRequest(parameters: ["foo": "bar"])
    )
}

private struct TestTarget: Target {
    let baseURL: URL
    let path: String
    let method: APIClient.HTTPMethod
    let task: APIClient.Task
}
