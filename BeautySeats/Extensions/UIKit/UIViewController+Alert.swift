//
//  UIViewController+Alert.swift
//  BeautySeats
//
//  Created by Charmy Mehta on 11/5/2563 BE.
//  Copyright © 2563 Charmy Mehta. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlertView(_ title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
