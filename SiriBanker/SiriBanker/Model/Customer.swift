//
//  Customer.swift
//  SiriBanker
//
//  Created by Mark Broski on 6/8/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import Foundation

var customer: Customer = Customer.defaultCustomer()

enum JSONError: Error {
    case missingFile
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

struct Customer: Decodable {
    let customerName: String
    let customerId: String
    let accounts: [Account]

    static func defaultCustomer() -> Customer {
        let path = Bundle.main.path(forResource: "startupData", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let decoder = JSONDecoder()
        let customer = try! decoder.decode(Customer.self, from: data)
//        print(customer)
        return customer
    }
}

//
// do {
//        if let path = Bundle.main.path(forResource: "startUpData", ofType: "json") {
//
//                      let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                    let decoder = JSONDecoder()
//                    customer = try decoder.decode(Customer.self, from: data)
//                    }
//
//      } else {
//         throw JSONError.missingFile
//      }
//
//      catch  {
//                    return Customer(customerName:"", customerId:"", accounts:[Account]())
//    }
