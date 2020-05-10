//
//  Api.swift
//  BeautySeats
//
//  Created by Charmy Mehta on 10/5/2563 BE.
//  Copyright © 2563 Charmy Mehta. All rights reserved.
//

import Foundation
import Alamofire

enum Api {
    case currencies
    case beautyServices
}

extension Api: Endpoint {
    var baseUrl: String {
        return Environment.configuration(For: .serverURL)
    }
    
    var path: String {
        switch self {
        case .currencies:
            return "/currencies.json"
        case .beautyServices:
            return "/services.json"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .currencies, .beautyServices:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .currencies, .beautyServices:
            var parameters = Parameters()
            parameters["auth"] = Environment.configuration(For: .authKey)
            return parameters
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .currencies, .beautyServices:
            return URLEncoding.default
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .currencies, .beautyServices:
            return nil
        }
    }
}
