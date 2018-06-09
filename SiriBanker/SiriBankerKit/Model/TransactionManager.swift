//
//  TransactionManager.swift
//  SiriBankerKit
//
//  Created by Allen White on 6/9/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import Foundation

public class TransactionManager {
    public static var shared = TransactionManager()

    public var customer: Customer?
    public var toAccount: Account?
    public var fromAccount: Account?
    public var amount: Double?
    public var memo: String?
    public var remainingAccounts: [Account] {
        return customer?.accounts.filter({ $0 != toAccount && $0 != fromAccount }) ?? []
    }

    public func sendTransaction() -> TransationCreationStatus {
		guard var customer = customer, let toAcct = toAccount, let fromAcct = fromAccount, let amount = amount else {
			return .failure(.invalidData)
		}
		let fromTransaction = Transaction(amount: -amount)
		let toTransaction = Transaction(amount: amount)
		customer.accounts.first(where: { $0 == toAcct })?.transactions.append(toTransaction)
		customer.accounts.first(where: { $0 == fromAcct })?.transactions.append(fromTransaction)
        clearTransaction()
        return .success
    }

    public func clearTransaction() {
        customer = nil
        toAccount = nil
        fromAccount = nil
        amount = nil
        memo = nil
    }
}

public enum TransationCreationStatus {
    case success
    case failure(TransactionFailureDescription)

    public var alertObj: AlertObject {
        switch self {
        case .success:
            return AlertObject(title: "Success!", msg: "Transfer Completed.")
        case let .failure(reason):
            return AlertObject(title: "Whoops!", msg: reason.alertMsg)
        }
    }
}

public enum TransactionFailureDescription {
    case invalidData
    case insufficientFunds

    var alertMsg: String {
        switch self {
        case .invalidData:
            return "There is something wrong with the data you entered."
        case .insufficientFunds:
            return "You do not have the necessary funds to complete this transaction."
        }
    }
}

public struct AlertObject {
    public let title: String
    public let msg: String
}
