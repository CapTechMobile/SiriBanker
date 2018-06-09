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

    private func copyDefaultDataIfNecessary(urls: CustomerDataURLs) throws {

        if !customerDataFileExistsInDocumentsDirectory(urls: urls) {
            try fileManager.copyItem(at: urls.defaultCustomerDataURL, to: urls.customerDataURL)
        }
    }

    private func loadCustomerObjectFromFile(urls: CustomerDataURLs) throws -> Customer {

        let data = try Data(contentsOf: URL(fileURLWithPath: urls.customerDataURL.path), options: .mappedIfSafe)
        let decoder = JSONDecoder()
        let customer = try! decoder.decode(Customer.self, from: data)
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

/*
 public class CustomerFileManager {
 fileprivate let fileManager = FileManager.default
 fileprivate let bundle = Bundle(for: CustomerFileManager.self)
 fileprivate let customerDataFileName = "customerData"
 fileprivate let customerDataFileExtension = "json"

 struct CustomerDataURLs {
 //        let defaultCustomerDataURL: URL
 //        let customerDataURL: URL

 init () throws {
 //            let Clazz = CustomerDataURLs.self
 //            guard  let defaultCustomerDataURL = defaultCustomerDataURL else { throw FileError.defaultDataNotFound }
 //            guard let customerDataURL = customerDataURL else { throw FileError.documentsDirectoryNotFound }
 //
 //
 //            self.defaultCustomerDataURL = defaultCustomerDataURL
 //            self.customerDataURL = customerDataURL
 }

 private var defaultCustomerDataURL: URL? = {
 bundle.url(forResource: customerDataFileName, withExtension: customerDataFileExtension)
 }()

 private static var documentDirectoryURL: URL? = {
 fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
 }()

 private static var  fileManager = FileManager.default
 private static var bundle = Bundle(for: CustomerFileManager.self)

 private static var customerDataURL: URL? = {
 documentDirectoryURL?.appendingPathComponent("\(customerDataFileName).\(customerDataFileExtension)")
 }()
 }

 func runOnColdStart() throws {
 let customerDataURLs = buildCustomerDataURLs()

 }

 func copyCustomerDataIfNecessary(customerDataUrls: CustomerDataURLs) {
 if !customerDataExistsInDocumentsDirectory(customerDataUrls: customerDataURLs) {
 try fileManager.copyItem(at: customerDataUrls.defaultCustomerDataURL, to: customerDataUrls.cust)

 }

 }

 func customerDataExistsInDocumentsDirectory(customerDataUrls: CustomerDataURLs) -> Bool {
 return fileManager.fileExists(atPath: customerDataUrls.customerDataURL.path)
 }

 fileprivate func copyCustomerDataIfNecessary(preloadedCustomerData: URL, customerFileURL: URL) throws {
 if !customerDataExistsInDocumentsDirectory {
 do {
 try fileManager.copyItem(at: preloadedCustomerData, to: customerFileURL)
 } catch {
 throw CustomerFileManagerError.fileCopyError
 }
 }
 }

 fileprivate func buildCustomerDataURLs() throws -> customerDataURLs  {
 guard let customerDataURL = customerDataURL else { throw FileError.documentsDirectoryNotFound }
 guard  let defaultCustomerDataURL = defaultCustomerDataURL else { throw FileError.defaultDataNotFound }

 return customerDataURLs(defaultCustomerDataURL: defaultCustomerDataURL, customerDataURL: customerDataURL)
 }

 }

 extension CustomerFileManager {

 public enum FileError: Error {
 case documentsDirectoryNotFound
 case defaultDataNotFound
 case fileCopyError
 }
 }
 */
