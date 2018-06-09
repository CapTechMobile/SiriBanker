//
//  Account.swift
//  SiriBanker
//
//  Created by Mark Broski on 6/8/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import Foundation

public enum AccountType: String {
    case checking
    case savings
}

public struct Account: Decodable, Equatable {
    public static func == (lhs: Account, rhs: Account) -> Bool {
        return lhs.accountName == rhs.accountName &&
            lhs.accountType == rhs.accountType &&
            lhs.statementBalance == rhs.statementBalance &&
            lhs.transactions.count == rhs.transactions.count
    }

    public let accountName: String
    public let accountType: AccountType
    public var statementBalance: Double {
        return transactions.reduce(0, { $0 + $1.amount })
    }

    public let transactions: [Transaction]
    public var transactionsSorted: [Transaction] {
        var transactions = self.transactions
        transactions.sort(by: { $0.date > $1.date })
        return transactions
    }

    enum CodingKeys: String, CodingKey {
        case accountName
        case accountType
        case transactions
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self) // defining our (keyed) container
        accountName = try container.decode(String.self, forKey: .accountName) // extracting the data
        let accountTypeString = try container.decode(String.self, forKey: CodingKeys.accountType)
        accountType = AccountType(rawValue: accountTypeString)!
        transactions = try container.decode([Transaction].self, forKey: .transactions)
    }
}
