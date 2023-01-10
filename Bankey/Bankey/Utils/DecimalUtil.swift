//
//  DecimalUtil.swift
//  Bankey
//
//  Created by Jose Sousa on 10/01/2023.
//

import Foundation

extension Decimal {
    
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
