//
//  BeautyServiceCell.swift
//  BeautySeats
//
//  Created by Charmy Mehta on 10/5/2563 BE.
//  Copyright © 2563 Charmy Mehta. All rights reserved.
//

import UIKit

class BeautyServiceCell: UITableViewCell {
    
    static let reuseIdentifier = "BeautyServiceCell"
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - View Life Cycle
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    // MARK: - Data method
    func configure(_ viewModel: BeautyServiceCellViewModel) {
        nameLabel.text = viewModel.name
        priceLabel.text = viewModel.price
    }
}
