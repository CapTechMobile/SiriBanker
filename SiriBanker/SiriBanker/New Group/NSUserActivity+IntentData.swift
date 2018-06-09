//
//  NSUserActivity+IntentData.swift
//  SiriBanker
//
//  Created by Allen White on 6/9/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import Foundation
#if os(iOS)
	import CoreSpotlight
	import UIKit
#endif


extension NSUserActivity {
	
	private static let searchableItemContentType = "Accounts"

	public static let viewMenuActivityType = "com.example.apple-samplecode.SoupChef.viewMenu"
}
