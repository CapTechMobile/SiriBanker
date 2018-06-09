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

public struct Customer: Decodable {
    public let customerName: String
    public let customerId: String
    public let accounts: [Account]

    static func defaultCustomer() -> Customer {
        let bundle = Bundle(for: TestClass.self)
        let path = bundle.path(forResource: "startupData", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let decoder = JSONDecoder()
        let customer = try! decoder.decode(Customer.self, from: data)
        return customer
    }
}
