//
//  Transaction.swift
//  SiriBanker
//
//  Created by Mark Broski on 6/8/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import Foundation
import Intents

public struct Transaction: Codable {
    public let id: String
    public let amount: Double
    public let date: Date
    public let memo: String

    enum CodingKeys: String, CodingKey {
        case id
        case amount
        case date
        case memo
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self) // defining our (keyed) container
        id = try container.decode(String.self, forKey: .id) // extracting the data
        amount = try container.decode(Double.self, forKey: .amount) // extracting the data
        let dateString = try container.decode(String.self, forKey: .date)
        date = Formatters.networkDateFormatter.date(from: dateString)!
        memo = try container.decode(String.self, forKey: .memo)
    }

    public init(amount: Double, memo: String = "") {
        self.amount = amount
        date = Date()
        self.memo = memo
        id = Transaction.randomString(length: 10)
    }

    fileprivate static func randomString(length: Int) -> String {
        let letters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        var randomString = ""

        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(amount, forKey: .amount)
        let dateString = Formatters.networkDateFormatter.string(from: date)
        try container.encode(dateString, forKey: .date)
        try container.encode(memo, forKey: .memo)
    }

    func convertToIntentTransaction() -> IntentTransaction {
        return IntentTransaction(transaction: self)
    }
}

public struct IntentTransaction {
    let transactionAmount: INPaymentAmount
    let transactionScheduledDate: INDateComponentsRange
    let transactionNote: String

    init(transaction: Transaction) {
        let decimalValue = NSDecimalNumber(decimal: NSNumber(value: transaction.amount).decimalValue)
        transactionAmount = INPaymentAmount(
            amountType: .unknown,
            amount: INCurrencyAmount(amount: decimalValue, currencyCode: "USD")
        )
        let nowComponents = Calendar.current.dateComponents([.year, .month, .day], from: transaction.date)
        transactionScheduledDate = INDateComponentsRange(start: nowComponents, end: nowComponents)
        transactionNote = transaction.memo
    }
}
