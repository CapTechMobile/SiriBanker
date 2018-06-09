//
//  AppDelegate.swift
//  SiriBanker
//
//  Created by Mark Broski on 6/8/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import Intents
import os.log
import SiriBankerKit
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initializeCustomerData()
        requestAuthorizationForSIRI()
        return true
    }

    func requestAuthorizationForSIRI() {
        INPreferences.requestSiriAuthorization { status in
            if status == .authorized {
                print("Hey, Siri!")
            } else {
                print("Nay, Siri!")
            }
        }
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

    func application(_: UIApplication, continue userActivity: NSUserActivity, restorationHandler _: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        /* if let intent = userActivity.interaction?.intent as? OrderSoupIntent {
         handle(intent)
         return true
         } else */ if userActivity.activityType == NSUserActivity.viewAccountActivityType {
            handle(userActivity)
            return true
        }
        return false
    }

    private func handle(_: NSUserActivity) {
        guard let window = window,
            let rootViewController = window.rootViewController as? UITabBarController,
            let accountSummaryNavVC = rootViewController.viewControllers?.first as? UINavigationController else {
            os_log("Failed to access AccountsSummaryViewController.")
            return
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailsView = storyboard.instantiateViewController(withIdentifier: "AccountDetailsViewController") as? AccountDetailsViewController else {
            return
        }
        detailsView.account = customer.accounts.first(where: { $0.accountType == .checking })
        accountSummaryNavVC.popToRootViewController(animated: false)
        accountSummaryNavVC.pushViewController(detailsView, animated: true)
    }
}
