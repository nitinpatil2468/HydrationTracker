//
//  UserdefaultManager.swift
//  WaterTracker
//
//  Created by Abcom on 31/03/24.
//

import Foundation

class UserDefaultManager {
    static let standard = UserDefaultManager()
    private init() {
    }
    
    
    var targetGoal:Int {
        get {
            return UserDefaults.standard.integer(forKey: "targetGoal")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "targetGoal")
        }
    }
    
}
