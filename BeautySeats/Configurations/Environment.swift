//
//  Environment.swift
//  BeautySeats
//
//  Created by Charmy Mehta on 10/5/2563 BE.
//  Copyright © 2563 Charmy Mehta. All rights reserved.
//

import Foundation

public enum ConfigKey: String {
    case serverURL = "server_url"
    case authKey = "auth_key"
}

struct Environment {
    fileprivate static var infoDict: [String: Any]  {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            } else {
                fatalError("Plist file not found")
            }
        }
    }
    
    static func configuration(For key: ConfigKey) -> String {
        guard let configuration = infoDict[key.rawValue] as? String else { return "" }
        return configuration
    }
}
