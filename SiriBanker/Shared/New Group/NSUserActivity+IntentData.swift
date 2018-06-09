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

	/// matches value in info.plist file
	public static let viewAccountActivityType = "com.SiriBanker.viewAccount"
	
	public static func viewAccountActivity(accountName: String) -> NSUserActivity {
		let userActivity = NSUserActivity(activityType: NSUserActivity.viewAccountActivityType)
		
		// User activites should be as rich as possible, with icons and localized strings for appropiate content attributes.
		userActivity.title = NSLocalizedString("VIEW_ACCOUNT_DETAILS", bundle: Bundle.main, comment: "View account activity title")
		userActivity.isEligibleForSearch = true
		userActivity.isEligibleForPrediction = true
		userActivity.userInfo = ["account_name": accountName]
		
	#if os(iOS)
		let attributes = CSSearchableItemAttributeSet(itemContentType: NSUserActivity.searchableItemContentType)
//		attributes.thumbnailData = #imageLiteral(resourceName: "tomato").pngData() // Used as an icon in Search.
		attributes.keywords = userActivity.viewAccountSearchableKeywords
		attributes.displayName = NSLocalizedString("VIEW_ACCOUNT_DETAILS", bundle: Bundle.siriBankerBundle, comment: "View account activity title")
		let description = NSLocalizedString("VIEW_MENU_CONTENT_DESCRIPTION", bundle: Bundle.siriBankerBundle, comment: "View account content description")
		attributes.contentDescription = description
		userActivity.contentAttributeSet = attributes
	#endif
		let phrase = NSLocalizedString("VIEW_ACCOUNT_SUGGESTED_PHRASE", bundle: Bundle.siriBankerBundle, comment: "Voice shortcut suggested phrase")
		userActivity.suggestedInvocationPhrase = phrase
		return userActivity
	}
	
	
	private var viewAccountSearchableKeywords: [String] {
		return [NSLocalizedString("ORDER", bundle: Bundle.siriBankerBundle, comment: "Searchable keyword"),
				NSLocalizedString("SOUP", bundle: Bundle.siriBankerBundle, comment: "Searchable keyword"),
				NSLocalizedString("MENU", bundle: Bundle.siriBankerBundle, comment: "Searchable keyword")
		]
	}
}
