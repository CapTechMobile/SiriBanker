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

    public func sendTransaction() {
        clearTransaction()
    }

    public func clearTransaction() {
        customer = nil
        toAccount = nil
        fromAccount = nil
        amount = nil
        memo = nil
    }
}
