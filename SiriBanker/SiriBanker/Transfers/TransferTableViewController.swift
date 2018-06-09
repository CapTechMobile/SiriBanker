//
//  TransferTableViewController.swift
//  SiriBanker
//
//  Created by Allen White on 6/8/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import SiriBankerKit
import UIKit

class TransferTableViewController: UITableViewController {
    @IBOutlet var toLabel: UILabel!
    @IBOutlet var fromLabel: UILabel!
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var transferButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let toAccount = customer.toAccount {
            toLabel.text = "To: \(toAccount.accountName)"
        }
        if let fromAccount = customer.fromAccount {
            fromLabel.text = "From: \(fromAccount.accountName)"
        }
    }

    override func tableView(_: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row == 0 || indexPath.row == 1 {
            return indexPath
        }
        return nil
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let selectAccountVC = storyboard.instantiateViewController(withIdentifier: "SelectAccountTableViewController") as? SelectAccountTableViewController else {
            return
        }

        if indexPath.row == 0 {
            selectAccountVC.isSelectingToAccount = true
        } else {
            selectAccountVC.isSelectingToAccount = false
        }
        navigationController?.pushViewController(selectAccountVC, animated: true)
    }
}
