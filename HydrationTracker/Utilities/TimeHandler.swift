//
//  TimeHandler.swift
//  WaterTracker
//
//  Created by Abcom on 30/03/24.
//

import Foundation

class TimeHandler{
    static func getDateInFormate(formate:String = "HH:mm a",date:Date = Date())->String{
        let dateformat = DateFormatter()
        dateformat.dateFormat = formate
        return dateformat.string(from: date)
    }
}
