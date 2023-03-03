//
//  ModifiesRequest.swift
//  
//
//  Created by Vladislav Lisianskii on 03.03.2023.
//

import Foundation

public protocol ModifiesRequest {
    func modify(_ request: inout URLRequest)
}
