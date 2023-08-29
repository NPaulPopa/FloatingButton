//
//  File.swift
//  
//
//  Created by Paul on 29/08/2023.
//

import UIKit

public extension CGFloat {
    func rounded(toPlaces places: Int) -> CGFloat {
        let multiplier = pow(10.0, CGFloat(places))
        return (self * multiplier).rounded() / multiplier
    }
}
