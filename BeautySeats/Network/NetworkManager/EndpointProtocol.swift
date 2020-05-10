//
//  EndpointProtocol.swift
//  BeautySeats
//
//  Created by Charmy Mehta on 10/5/2563 BE.
//  Copyright © 2563 Charmy Mehta. All rights reserved.
//

import Foundation
import Alamofire

protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: Parameters? { get }
    var parameterEncoding: ParameterEncoding { get }
    var headers: HTTPHeaders? { get }
}

extension Endpoint {
    var url: URL {
        return URL(string: "\(baseUrl)\(path)")!
    }
}
