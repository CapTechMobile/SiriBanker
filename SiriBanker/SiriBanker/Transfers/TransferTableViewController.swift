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
        tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        transactionManager.currentCustomer = customer
        if let toAccount = TransactionManager.shared.toAccount {
            toLabel.text = "To: \(toAccount.accountName)"
        }
        if let fromAccount = TransactionManager.shared.fromAccount {
            fromLabel.text = "From: \(fromAccount.accountName)"
        }
    }

    @IBAction func transferButtonTapped(_: Any) {
        if let amountText = amountTextField.text {
            transactionManager.amount = Double(amountText)
            let response = transactionManager.sendTransaction()
            AlertManager.showAlert(response.alertObj, on: self) { _ in
                if response == TransationCreationStatus.success {
                    self.clearView()
                    self.tabBarController?.selectedIndex = 0
                }
            }
        } else {
            AlertManager.showAlert(TransationCreationStatus.failure(TransactionFailureDescription.invalidData).alertObj, on: self)
        }
    }

    fileprivate func clearView() {
        toLabel.text = "To: "
        fromLabel.text = "From: "
        amountTextField.text = ""
    }

    // MARK: - tableview stuff

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
			selectAccountVC.isSelectingToAccount = false
        } else {
            selectAccountVC.isSelectingToAccount = true
        }
        navigationController?.pushViewController(selectAccountVC, animated: true)
    }
}
