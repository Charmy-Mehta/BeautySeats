//
//  CurrencyServices.swift
//  BeautySeats
//
//  Created by Charmy Mehta on 10/5/2563 BE.
//  Copyright © 2563 Charmy Mehta. All rights reserved.
//

import Foundation
import RxSwift

protocol CurrencyProviderProtocol {
    func fetchCurrencies() -> Observable<[Currency]>
}

class CurrencyProvider: CurrencyProviderProtocol {
    private var networkManager: NetworkManagerProtocol
    
    init(_ networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetchCurrencies() -> Observable<[Currency]> {
        return networkManager.load(api: Api.currencies).asObservable()
    }
}
