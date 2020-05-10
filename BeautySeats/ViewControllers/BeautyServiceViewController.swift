//
//  BeautyServiceViewController.swift
//  BeautySeats
//
//  Created by Charmy Mehta on 10/5/2563 BE.
//  Copyright © 2563 Charmy Mehta. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class BeautyServiceViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!

    // MARK: - Properties
    var viewModel: BeautyServiceDataSource = BeautyServiceViewModel()
    
    // MARK: - Private properties
    private let disposeBag = DisposeBag()
    
    // MARK: - View life-cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    // MARK: - Data methods
    private func setupNavigationBar() {
        title = "Beauty Services"
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        navigationController?.navigationBar.barTintColor = UIColor.white // Red
        navigationController?.navigationBar.tintColor = UIColor.systemBlue // White
        
        navigationItem.largeTitleDisplayMode = .automatic
        let barItemAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 26, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = barItemAttributes // White
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black] // White
        
        navigationController?.navigationBar.barStyle = .default
    }
    
    private func setupViewModel() {
        viewModel.servicesRequestState
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] state in
                switch state {
                case .success:
                    self?.tableView.reloadData()
                case .failure:
                    self?.showAlertView("BeautySeat", message: "Something went wrong. Please try again later.")
                }
            })
            .disposed(by: disposeBag)
        viewModel.isLoading.bind(to: indicatorView.rx.isAnimating).disposed(by: disposeBag)
        viewModel.fetchBeautyServices()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.estimatedRowHeight = 65.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.hideEmptyCells()
    }
}

// MARK: - UITableViewDataSource
extension BeautyServiceViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeautyServiceCell.reuseIdentifier) as? BeautyServiceCell else {
            return UITableViewCell()
        }
        cell.configure(viewModel.beautyServiceAt(indexPath))
        return cell
    }
}

extension BeautyServiceViewController {
    static func storyboardInstance() -> BeautyServiceViewController {
        let beautyServiceViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BeautyServiceViewController") as! BeautyServiceViewController
        return beautyServiceViewController
    }
}
