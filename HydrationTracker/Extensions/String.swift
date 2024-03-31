//
//  String.swift
//  WaterTracker
//
//  Created by Abcom on 30/03/24.
//

import Foundation

extension String {
    
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
}
