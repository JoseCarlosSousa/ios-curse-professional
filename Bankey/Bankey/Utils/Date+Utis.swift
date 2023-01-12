//
//  Date+Utis.swift
//  Bankey
//
//  Created by Jose Sousa on 11/01/2023.
//

import Foundation

extension Date {
    
    static var bankeyDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "MDT")
        return formatter
    }
    
    func monthDayYearString() -> String {
        let dateFormatter = Date.bankeyDateFormatter
        dateFormatter.dateFormat = "MMMM d, yyyy"
        return dateFormatter.string(from: self)
    }
}
