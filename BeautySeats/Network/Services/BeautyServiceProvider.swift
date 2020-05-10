//
//  BeautyServiceProvider.swift
//  BeautySeats
//
//  Created by Charmy Mehta on 10/5/2563 BE.
//  Copyright © 2563 Charmy Mehta. All rights reserved.
//

import Foundation
import RxSwift

protocol BeautyServiceProviderProtocol {
    func fetchBeautyServices() -> Observable<[BeautyService]>
}

class BeautyServiceProvider: BeautyServiceProviderProtocol {
    private var networkManager: NetworkManagerProtocol
    
    init(_ networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetchBeautyServices() -> Observable<[BeautyService]> {
        return networkManager.load(api: Api.beautyServices).asObservable()
    }
}
