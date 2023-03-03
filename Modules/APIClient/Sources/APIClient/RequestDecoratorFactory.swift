//
//  RequestDecoratorFactory.swift
//  
//
//  Created by Vladislav Lisianskii on 04.03.2023.
//

import Foundation

struct RequestDecoratorFactory {

    // MARK: - Public
    func requestDecorator(for target: Target) -> DecoratesRequest {

        let httpMethodModificator = HTTPMethodRequestModificator(httpMethod: target.method)
        let httpMethodDecorator = RequestDecorator(modificator: httpMethodModificator)

        var decorators: [DecoratesRequest] = [httpMethodDecorator]

        switch target.task {
        case let .queryRequest(parameters):
            let queryStringModificator = QueryStringRequestModificator(parameters: parameters)
            let decorator = RequestDecorator(modificator: queryStringModificator)
            decorators.append(decorator)
        }

        return mergeDecorators(decorators)
    }

    // MARK: - Private
    private func mergeDecorators(_ decorators: [DecoratesRequest]) -> DecoratesRequest {
        // Array is reversed to preserve decorators hierarchy. Otherwise last decorator in list would become root.
        let reversedDecorators = decorators.reversed()
        guard let first = reversedDecorators.first else {
            fatalError("Decorators array must contain at least HTTPMethodDecorator")
        }
        return reversedDecorators.dropFirst(1).reduce(first) { child, parent in
            parent.next = child
            return parent
        }
    }
}
