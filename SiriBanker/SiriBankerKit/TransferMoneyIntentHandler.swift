//
//  TransferMoneyIntentHandler.swift
//  SiriBankerKit
//
//  Created by Mark Broski on 6/9/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import Foundation
import Intents

public class TransferMoneyIntentHandler: NSObject, INTransferMoneyIntentHandling {
    public func handle(intent _: INTransferMoneyIntent, completion _: @escaping (INTransferMoneyIntentResponse) -> Void) {
    }

    /// - Tag: confirm_intent
    public func confirm(intent _: INTransferMoneyIntent, completion _: @escaping (INTransferMoneyIntentHandling) -> Void) {
        //        /*
        //        The confirm phase provides an opportunity for you to perform any final validation of the intent parameters and to
        //        verify that any needed services are available. You might confirm that you can communicate with your company’s server
        //         */
        //        let soupMenuManager = SoupMenuManager()
        //        guard let soup = intent.soup,
        //            let identifier = soup.identifier,
        //            let menuItem = soupMenuManager.findItem(identifier: identifier) else {
        //                completion(OrderSoupIntentResponse(code: .failure, userActivity: nil))
        //                return
        //        }
        //
        //        if menuItem.isAvailable == false {
        //            //  Here's an example of how to use a custom response for a failure case when a particular soup item is unavailable.
        //            completion(OrderSoupIntentResponse.failureSoupUnavailable(soup: soup))
        //            return
        //        }
        //
        //        // Once the intent is validated, indicate that the intent is ready to handle.
        //        completion(OrderSoupIntentResponse(code: .ready, userActivity: nil))
    }

    public func handle(intent _: INTransferMoneyIntent, completion _: @escaping (INTransferMoneyIntentHandling) -> Void) {
        //        guard let soup = intent.soup,
        //            let order = Order(from: intent)
        //        else {
        //            completion(OrderSoupIntentResponse(code: .failure, userActivity: nil))
        //            return
        //        }
        //
        //        //  The handle method is also an appropriate place to handle payment via Apple Pay.
        //        //  A declined payment is another example of a failure case that could take advantage of a custom response.
        //
        //        //  Place the soup order via the order manager.
        //        let orderManager = SoupOrderDataManager()
        //        orderManager.placeOrder(order: order)
        //
        //        //  For the success case, we want to indicate a wait time to the user so that they know when their soup order will be ready.
        //        //  Ths sample uses a hardcoded value, but your implementation could use a time interval returned by your server.
        //        completion(OrderSoupIntentResponse.success(soup: soup, waitTime: 10))
    }
}
