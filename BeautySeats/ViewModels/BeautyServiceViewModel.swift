//
//  BeautyServiceViewModel.swift
//  BeautySeats
//
//  Created by Charmy Mehta on 10/5/2563 BE.
//  Copyright © 2563 Charmy Mehta. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol BeautyServiceDataSource {
    var servicesRequestState: Observable<NetworkManager.State> { get }
    var isLoading: Observable<Bool> { get }
    
    func fetchBeautyServices()
    
    func numberOfSections() -> Int
    func numberOfRowsInSection(_ section: Int) -> Int
    func beautyServiceAt(_ indexPath: IndexPath) -> BeautyServiceCellViewModel
}

final class BeautyServiceViewModel: BeautyServiceDataSource {
    let servicesRequestState: Observable<NetworkManager.State>
    let isLoading: Observable<Bool>
    
    private let beautyServiceRequestStateSubject = PublishSubject<NetworkManager.State>()
    private let loadingSubject = BehaviorRelay<Bool>(value: true)
    private var services: [BeautyServiceCellViewModel]
    
    private let beautyServiceProvider: BeautyServiceProviderProtocol
    private let backgroundScheduler: SchedulerType
    private let currencyViewModel = CurrencyViewModel()
    
    private let disposeBag = DisposeBag()
    
    init(_ beautyServiceProvider: BeautyServiceProviderProtocol = BeautyServiceProvider(), withSchedulerType backgroundScheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
        self.beautyServiceProvider = beautyServiceProvider
        self.backgroundScheduler = backgroundScheduler
        
        servicesRequestState = beautyServiceRequestStateSubject.asObservable()
        services = []
        isLoading = loadingSubject.asObservable()
    }
    
    func fetchBeautyServices() {
        beautyServiceProvider.fetchBeautyServices().subscribeOn(backgroundScheduler)
            .subscribe(onNext: { [weak self] services in
                self?.services = services.map({
                    let currencyName = self?.getCurrencyName($0.currency_id) ?? ""
                    return BeautyServiceCellViewModel(name: $0.name, price: "\($0.price) \(currencyName)")
                })
                self?.beautyServiceRequestStateSubject.onNext(.success(services))
                self?.loadingSubject.accept(false)
                }, onError: { [weak self] error in
                    self?.beautyServiceRequestStateSubject.onNext(.failure)
                    self?.loadingSubject.accept(false)
            }).disposed(by: disposeBag)
    }
    
    private func getCurrencyName(_ curremcyId: Int) -> String {
        guard let currencyName = currencyViewModel.currencies.first(where: { $0.id == curremcyId})?.label else {
            return ""
        }
        return currencyName
    }
}

extension BeautyServiceViewModel {
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return services.count
    }
    
    func beautyServiceAt(_ indexPath: IndexPath) -> BeautyServiceCellViewModel {
        return services[indexPath.row]
    }
}
