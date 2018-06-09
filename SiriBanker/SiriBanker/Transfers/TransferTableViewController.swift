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
    fileprivate var transactionManager = TransactionManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        transactionManager.customer = customer
        tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let toAccount = transactionManager.toAccount {
            toLabel.text = "To: \(toAccount.accountName)"
        }
        if let fromAccount = transactionManager.fromAccount {
            fromLabel.text = "From: \(fromAccount.accountName)"
        }
    }

    @IBAction func transferButtonTapped(_: Any) {
        let response = transactionManager.sendTransaction()
        AlertManager.showAlert(response.alertObj, on: self)
        clearView()
    }

    fileprivate func clearView() {
        toLabel.text = "To: "
        fromLabel.text = "From: "
        amountTextField.text = ""
    }

    // MARK: - TableView stuff

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
