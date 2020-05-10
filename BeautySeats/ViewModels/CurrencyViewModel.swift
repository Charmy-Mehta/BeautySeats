//
//  CurrencyViewModel.swift
//  BeautySeats
//
//  Created by Charmy Mehta on 10/5/2563 BE.
//  Copyright © 2563 Charmy Mehta. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol CurrencyDataSource {
    var currencyRequestState: Observable<NetworkManager.State> { get }
    var isLoading: Observable<Bool> { get }
    var currencies: [Currency] { get }
    func fetchCurrencies()
    func saveCurrencies(_ currencies: [Currency])
}

final class CurrencyViewModel: CurrencyDataSource {
    var currencies: [Currency] {
        get {
            return UserDefaults.standard.currencies ?? []
        }
    }
    let currencyRequestState: Observable<NetworkManager.State>
    let isLoading: Observable<Bool>
    
    private let currencyRequestStateSubject = PublishSubject<NetworkManager.State>()
    private let loadingSubject = BehaviorRelay<Bool>(value: true)
    
    private let currencyProvider: CurrencyProviderProtocol
    private let backgroundScheduler: SchedulerType
    
    private let disposeBag = DisposeBag()
    
    init(_ currencyProvider: CurrencyProviderProtocol = CurrencyProvider(), withSchedulerType backgroundScheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
        self.currencyProvider = currencyProvider
        self.backgroundScheduler = backgroundScheduler
        
        currencyRequestState = currencyRequestStateSubject.asObservable()
        isLoading = loadingSubject.asObservable()
    }
    
    func fetchCurrencies() {
        currencyProvider.fetchCurrencies().subscribeOn(backgroundScheduler)
            .subscribe(onNext: { [weak self] currencies in
                self?.saveCurrencies(currencies)
                self?.currencyRequestStateSubject.onNext(.success(currencies))
                self?.loadingSubject.accept(false)
                }, onError: { [weak self] error in
                    self?.currencyRequestStateSubject.onNext(.failure)
                    self?.loadingSubject.accept(false)
            }).disposed(by: disposeBag)
    }
    
    func saveCurrencies(_ currencies: [Currency]) {
        UserDefaults.standard.currencies = currencies
    }
}
