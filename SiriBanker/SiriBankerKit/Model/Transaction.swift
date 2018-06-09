//
//  Transaction.swift
//  SiriBanker
//
//  Created by Mark Broski on 6/8/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import Foundation

public struct Transaction: Decodable {
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
        date = DateFormatters.networkDateFormatter.date(from: dateString)!
        memo = try container.decode(String.self, forKey: .memo)
    }
}
