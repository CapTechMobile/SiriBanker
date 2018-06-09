//
//  CustomerManager.swift
//  SiriBankerKit
//
//  Created by Mark Broski on 6/9/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import Foundation

public class CustomerFileManager {
    private let fileManager = FileManager.default

    public init() {}

    public func runOnColdStart() throws {
        let urls = try CustomerDataURLs()
        try copyDefaultDataIfNecessary(urls: urls)
        customer = try loadCustomerObjectFromFile(urls: urls)
    }

    public func writeCustomerToDisk() throws {
        let urls = try CustomerDataURLs()

        let encoder = JSONEncoder()
        let customerData = try encoder.encode(customer)
        try customerData.write(to: urls.customerDataURL)
        print("just saved to \(urls.customerDataURL.path)")
    }

    private func copyDefaultDataIfNecessary(urls: CustomerDataURLs) throws {
        if !customerDataFileExistsInDocumentsDirectory(urls: urls) {
            try fileManager.copyItem(at: urls.defaultCustomerDataURL, to: urls.customerDataURL)
        }
    }

    private func loadCustomerObjectFromFile(urls: CustomerDataURLs) throws -> Customer {
        let data = try Data(contentsOf: URL(fileURLWithPath: urls.customerDataURL.path), options: .mappedIfSafe)
        let decoder = JSONDecoder()
        let customer = try decoder.decode(Customer.self, from: data)
        print(customer)
        return customer
    }

    private func customerDataFileExistsInDocumentsDirectory(urls: CustomerDataURLs) -> Bool {
        return fileManager.fileExists(atPath: urls.customerDataURL.path)
    }
}

public enum FileError: Error {
    case documentsDirectoryNotFound
    case defaultDataNotFound
    case fileCopyError
}

struct CustomerDataURLs {
    fileprivate let bundle = Bundle(for: CustomerFileManager.self)
    let defaultCustomerDataURL: URL
    let customerDataURL: URL

    fileprivate let fileManager = FileManager.default

    init() throws {
        guard let defaultCustomerDataURL = CustomerDataURLs.defaultCustomerDataURL else { throw FileError.defaultDataNotFound }
        self.defaultCustomerDataURL = defaultCustomerDataURL

        guard let customerDataURL = CustomerDataURLs.customerDataURL else { throw FileError.documentsDirectoryNotFound }
        self.customerDataURL = customerDataURL
    }

    private static var documentDirectoryURL: URL? = {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }()

    private static var customerDataURL: URL? {
        return documentDirectoryURL?.appendingPathComponent(URLNames.pathName)
    }

    private static var defaultCustomerDataURL: URL? = {
        let bundle = Bundle(for: CustomerFileManager.self)
        return bundle.url(forResource: URLNames.customerDataFileName, withExtension: URLNames.customerDataFileExtension)
    }()

    struct URLNames {
        static let customerDataFileName = "customerData"
        static let customerDataFileExtension = "json"
        static var pathName: String { return "\(customerDataFileName).\(customerDataFileExtension)" }
    }
}
