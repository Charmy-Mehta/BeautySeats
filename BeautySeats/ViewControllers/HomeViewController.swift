//
//  ViewController.swift
//  BeautySeats
//
//  Created by Charmy Mehta on 10/5/2563 BE.
//  Copyright © 2563 Charmy Mehta. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    // MARK: - Properties
    var viewModel: CurrencyDataSource = CurrencyViewModel()
    
    // MARK: - Private properties
    private let disposeBag = DisposeBag()
    
    // MARK: - View life-cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Data methods
    private func setupViewModel() {
        viewModel.currencyRequestState
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] state in
                switch state {
                case .failure:
                    self?.showAlertView("BeautySeat", message: "Something went wrong. Please try again later.")
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
        viewModel.isLoading.bind(to: indicatorView.rx.isAnimating).disposed(by: disposeBag)
        
        viewModel.fetchCurrencies()
    }
    
    // MARK: - IBActions
    @IBAction func continueTapped(_ sender: UIButton) {
        let viewController = BeautyServiceViewController.storyboardInstance()
        show(viewController, sender: sender)
    }
}
