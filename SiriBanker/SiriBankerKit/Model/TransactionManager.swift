//
//  TransactionManager.swift
//  SiriBankerKit
//
//  Created by Allen White on 6/9/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import Foundation
import Intents
import os.log

public enum TransactionManagerSender {
    case app
    case appExtension
}

public class TransactionManager {
    public static var shared = TransactionManager()

    public var currentCustomer: Customer?
    public var toAccount: Account?
    public var fromAccount: Account?
    public var amount: Double?
    public var memo: String?
    public var remainingAccounts: [Account] {
        return currentCustomer?.accounts.filter({ $0 != toAccount && $0 != fromAccount }) ?? []
    }

    public func sendTransaction(transactionManagerSender: TransactionManagerSender) -> TransationCreationStatus {
        guard var currentCustomer = currentCustomer, let toAcct = toAccount, let fromAcct = fromAccount, let amount = amount else {
            return .failure(.invalidData)
        }
        let memoString: String = memo ?? "Transfer from \(toAcct.accountName) to \(fromAcct.accountName)"

        let fromTransaction = Transaction(amount: -amount, memo: memoString)
        let toTransaction = Transaction(amount: amount, memo: memoString)
        currentCustomer.accounts = currentCustomer.accounts.map({
            if $0 == toAcct {
                var to = $0
                to.transactions.append(toTransaction)
                return to
            }
            return $0
        })
        currentCustomer.accounts = currentCustomer.accounts.map({
            if $0 == fromAcct {
                var from = $0
                from.transactions.append(fromTransaction)
                return from
            }
            return $0
        })
        customer = currentCustomer
        let customerFileManager = CustomerFileManager()
        do {
            try customerFileManager.writeCustomerToDisk()
        } catch {
            return .failure(.insufficientFunds)
        }

        if transactionManagerSender == .app {
            donateTransferIntent(transaction: toTransaction)
        }
        clearTransaction()
        return .success
    }

    func donateTransferIntent(transaction: Transaction) {
        guard let fromAccount = fromAccount, let toAccount = toAccount else { return }
        let intentTransaction = transaction.convertToIntentTransaction()
        let transferPaymentIntent = INTransferMoneyIntent(
            from: fromAccount.asIntentAccount(),
            to: toAccount.asIntentAccount(),
            transactionAmount: intentTransaction.transactionAmount,
            transactionScheduledDate: intentTransaction.transactionScheduledDate,
            transactionNote: intentTransaction.transactionNote
        )

        transferPaymentIntent.suggestedInvocationPhrase = "Transfer Money to \(toAccount.accountName)"

        let interaction = INInteraction(intent: transferPaymentIntent, response: nil)

        interaction.donate { error in
            if error != nil {
                if let error = error as NSError? {
                    os_log("Interaction donation failed: %@", log: OSLog.default, type: .error, error)
                }
            } else {
                os_log("Successfully donated interaction")
            }
        }
    }

    public func clearTransaction() {
        toAccount = nil
        fromAccount = nil
        amount = nil
        memo = nil
    }
}

public enum TransationCreationStatus: Equatable {
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
