//
//  AlertManager.swift
//  SiriBanker
//
//  Created by Allen White on 6/9/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import Foundation
import SiriBankerKit
import UIKit

struct AlertManager {
    static func showAlert(_ alertObj: AlertObject, on vc: UIViewController) {
        let alert = UIAlertController(title: alertObj.title, message: alertObj.msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
