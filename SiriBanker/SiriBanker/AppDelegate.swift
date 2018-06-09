//
//  AppDelegate.swift
//  SiriBanker
//
//  Created by Mark Broski on 6/8/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import Intents
import SiriBankerKit
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initializeCustomerData()
        return true
    }

    func initializeCustomerData() {
        do {
            let customerFileManager = CustomerFileManager()
            try customerFileManager.runOnColdStart()

        } catch {
            print("\(error)")
        }
    }
}
