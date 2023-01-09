//
//  LocalState.swift
//  Bankey
//
//  Created by Jose Sousa on 09/01/2023.
//

import Foundation

public class LocalState {
    
    private enum Keys: String {
        case hasOnboard
    }
    
    public static var hasOnboard: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.hasOnboard.rawValue)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.hasOnboard.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}
