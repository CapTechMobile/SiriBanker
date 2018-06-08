//
//  Account.swift
//  SiriBanker
//
//  Created by Mark Broski on 6/8/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import Foundation

enum AccountType: String {
    case checking
    case savings
}

struct Account: Decodable {
    let accountName: String
    let accountType: AccountType
    let statementBalance: Double
    let transactions: [Transaction]

    enum CodingKeys: String, CodingKey {
        case accountName
        case accountType
        case statementBalance
        case transactions
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self) // defining our (keyed) container
        accountName = try container.decode(String.self, forKey: .accountName) // extracting the data
        let accountTypeString = try container.decode(String.self, forKey: CodingKeys.accountType)
        accountType = AccountType(rawValue: accountTypeString)!
        statementBalance = try container.decode(Double.self, forKey: .statementBalance)
        transactions = try container.decode([Transaction].self, forKey: .transactions)
    }
}
