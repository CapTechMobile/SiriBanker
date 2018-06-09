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
	
	// MARK: - Handle Siri functionality
	
	func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
		/* if let intent = userActivity.interaction?.intent as? OrderSoupIntent {
			handle(intent)
			return true
		} else */ if userActivity.activityType == NSUserActivity.viewMenuActivityType {
			handleUserActivity()
			return true
		}
		return false
	}
	
	
	private func handleUserActivity() {
//		guard let window = window,
//			let rootViewController = window.rootViewController as? UINavigationController,
//			let orderHistoryViewController = rootViewController.viewControllers.first as? OrderHistoryTableViewController else {
//				os_log("Failed to access OrderHistoryTableViewController.")
//				return
//		}
//		let segue = OrderHistoryTableViewController.SegueIdentifiers.soupMenu.rawValue
//		orderHistoryViewController.performSegue(withIdentifier: segue, sender: nil)
	}
}
