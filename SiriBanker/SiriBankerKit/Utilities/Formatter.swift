//
//  Formatter.swift
//  SiriBanker
//
//  Created by Mark Broski on 6/8/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import Foundation

public class Formatters {
    public static var networkDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    public static var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()

    public static var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()

    public static func formatAsCurrency(double: Double) -> String? {
        let nd = NSNumber(value: double)
        return currencyFormatter.string(from: nd)
    }
}
