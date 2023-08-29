//
//  File.swift
//  
//
//  Created by Paul on 29/08/2023.
//

import Foundation

class MockDataGenerator {
    
    private let mockData: [String] = ["New York","South Carolina","Washington","Los Angeles", "Arkansas","Kensas City", "Omaha", "Santa Barbara"].shuffled()
        
    public func generateMockData() -> [String] {
        
        var randomData: [String] = []
        
        if mockData.count >= 50 {
            randomData = mockData
        } else {
            randomData += mockData
            
            while randomData.count < 50 {
                let randomIndex = Int.random(in: 0..<mockData.count)
                let randomString = mockData[randomIndex]
                randomData.append(randomString)
            }
        }
        
        return randomData
    }
}
