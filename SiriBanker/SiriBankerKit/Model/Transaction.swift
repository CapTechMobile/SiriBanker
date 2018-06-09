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
        date = Formatters.networkDateFormatter.date(from: dateString)!
        memo = try container.decode(String.self, forKey: .memo)
    }
	
	public init(amount: Double, memo: String = "") {
		self.amount = amount
		self.date = Date()
		self.memo = memo
		self.id = Transaction.randomString(length: 10)
	}
	
	fileprivate static func randomString(length: Int) -> String {
		let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
		let len = UInt32(letters.length)
		var randomString = ""
		
		for _ in 0 ..< length {
			let rand = arc4random_uniform(len)
			var nextChar = letters.character(at: Int(rand))
			randomString += NSString(characters: &nextChar, length: 1) as String
		}
		return randomString
	}
}
