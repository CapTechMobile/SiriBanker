//
//  TransferTableViewController.swift
//  SiriBanker
//
//  Created by Allen White on 6/8/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import UIKit

class TransferTableViewController: UITableViewController {
    @IBOutlet var toLabel: UILabel!
    @IBOutlet var fromLabel: UILabel!
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var transferButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
