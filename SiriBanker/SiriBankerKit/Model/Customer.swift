//
//  Customer.swift
//  SiriBanker
//
//  Created by Mark Broski on 6/8/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import Foundation

public var customer: Customer = Customer.defaultCustomer()

enum JSONError: Error {
    case missingFile
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

private class TestClass {
}

public struct Customer: Codable {
    public let customerName: String
    public let customerId: String
    public let accounts: [Account]

    static func defaultCustomer() -> Customer {
        return Customer(customerName: "", customerId: "", accounts: [Account]())
    }
}
