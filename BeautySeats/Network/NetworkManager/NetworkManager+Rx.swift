//
//  NetworkManager+Rx.swift
//  BeautySeats
//
//  Created by Charmy Mehta on 10/5/2563 BE.
//  Copyright © 2563 Charmy Mehta. All rights reserved.
//

import Alamofire
import RxSwift

protocol NetworkManagerProtocol {
    func load<T: Decodable>(api: Api) -> Observable<T>
}

extension NetworkManager: NetworkManagerProtocol {
    func load<T: Decodable>(api: Api) -> Observable<T> {
        return Observable.create { observer -> Disposable in
            NetworkManager.shared.request(api)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        guard let data = response.data else {
                            return
                        }
                        do {
                            let values = try JSONDecoder().decode(T.self, from: data)
                            observer.onNext(values)
                        } catch {
                            observer.onError(error)
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
            }
            return Disposables.create()
        }
    }
}
