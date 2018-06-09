//
//  Bundle+Extension.swift
//  SiriBanker
//
//  Created by Allen White on 6/9/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import Foundation
import SiriBankerKit

public extension Bundle {
    public static var siriBankerBundle: Bundle {
        // The bundle will change depending if the framework is for iOS or watchOS.
        return Bundle(for: CustomerFileManager.self)
    }
}
