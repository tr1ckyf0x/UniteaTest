//
//  Target.swift
//  
//
//  Created by Vladislav Lisianskii on 03.03.2023.
//

import Foundation

public protocol Target {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: Task { get }
}
