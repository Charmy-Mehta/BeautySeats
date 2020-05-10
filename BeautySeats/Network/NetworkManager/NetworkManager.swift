//
//  NetworkManager.swift
//  BeautySeats
//
//  Created by Charmy Mehta on 10/5/2563 BE.
//  Copyright © 2563 Charmy Mehta. All rights reserved.
//

import Alamofire
import RxSwift

class NetworkManager {
    enum State {
        case success(_ response: Any?)
        case failure
    }

    static let shared = NetworkManager(session: Session.default)
    
    private let session: Session
    
    private init(session: Session) {
        self.session = session
    }
    
    func request(_ endpoint: Endpoint) -> DataRequest {
        var headers = endpoint.headers
        if headers == nil {
            headers = [:]
        }
        return session.request(endpoint.url,
                               method: endpoint.httpMethod,
                               parameters: endpoint.parameters,
                               encoding: endpoint.parameterEncoding,
                               headers: headers).validate()
    }
}
