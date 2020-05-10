//
//  UserDefaults+Extension.swift
//  BeautySeats
//
//  Created by Charmy Mehta on 10/5/2563 BE.
//  Copyright © 2563 Charmy Mehta. All rights reserved.
//

import Foundation

extension UserDefaults {
    var currencies: [Currency]? {
        get {
            guard let currencyData = value(forKey: #function) as? Data else {
                return nil
            }
            return try? PropertyListDecoder().decode([Currency].self, from: currencyData)
        } set {
            guard let newValue = newValue else {
                return
            }
            set(try? PropertyListEncoder().encode(newValue), forKey: #function)
        }
    }
}
