//
//  UITableView+Extensions.swift
//  BeautySeats
//
//  Created by Charmy Mehta on 10/5/2563 BE.
//  Copyright © 2563 Charmy Mehta. All rights reserved.
//

import UIKit

extension UITableView {
    func hideEmptyCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
