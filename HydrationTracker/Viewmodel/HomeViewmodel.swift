//
//  HomeViewmodel.swift
//  WaterTracker
//
//  Created by Abcom on 30/03/24.
//

import Foundation

class HomeViewmodel{
    
    
    func getAlldata()->[Reading]{
        return CoreDataStack.shared.getAll()?.reversed() ?? []
    }
    
    func getCurrentStat()->Int{
        let readingArr = getAlldata()
        let totalSum = readingArr.map({Int($0.quantity)}).reduce(0, +)
        return totalSum
    }
    
    
    
    
    
}
