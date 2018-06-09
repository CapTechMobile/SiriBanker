//
//  Account.swift
//  SiriBanker
//
//  Created by Mark Broski on 6/8/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import Foundation
import Intents

public enum AccountType: String {
    case checking
    case savings

    func intentAccountType() -> INAccountType {
        switch self {
        case .checking: return INAccountType.checking
        case .savings: return INAccountType.saving
        }
    }
}

public struct Account: Codable, Equatable {
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

    public var transactions: [Transaction]
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

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(accountName, forKey: .accountName)
        try container.encode(accountType.rawValue, forKey: .accountType)
        try container.encode(transactions, forKey: .transactions)
    }
}

public extension Double {
    public var expressiveColor: UIColor {
        return self < 0 ? .red : UIColor(red: 0.0, green: 0.7, blue: 0.0, alpha: 1)
    }
}

public extension Account {

    func asIntentAccount() -> INPaymentAccount {

        let nickname = INSpeakableString(spokenPhrase: accountName)
        let number: String? = nil
        let accountType = self.accountType.intentAccountType()
        let organizationName = INSpeakableString(spokenPhrase: "Siri Banker")
        let balanceDecimalNumber = NSDecimalNumber(decimal: NSNumber(value: statementBalance).decimalValue)
        let inBalanceAmount = INBalanceAmount(amount: balanceDecimalNumber, balanceType: .money)
        let secondaryBalance: INBalanceAmount? = nil

        return INPaymentAccount(
            nickname: nickname,
            number: number,
            accountType: accountType,
            organizationName: organizationName,
            balance: inBalanceAmount,
            secondaryBalance: secondaryBalance)
    }
}
