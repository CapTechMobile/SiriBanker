//
//  AccountDetailsViewController.swift
//  SiriBanker
//
//  Created by Allen White on 6/8/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import SiriBankerKit
import UIKit

class AccountDetailsViewController: UIViewController {
    @IBOutlet var topBackgroundView: UIView!
    @IBOutlet var accountTypeLabel: UILabel!
    @IBOutlet var accountNumberLabel: UILabel!
    @IBOutlet var accountBalanceLabel: UILabel!
    @IBOutlet var accountBalanceDescLabel: UILabel!
    @IBOutlet var tableView: UITableView!

    fileprivate var dataSource: [Transaction] {
        return account?.transactionsSorted ?? []
    }

    var account: Account?
    fileprivate let cellIdentifier = "TransactionTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        guard let account = account else { return }

        accountTypeLabel.text = account.accountType.rawValue
        accountNumberLabel.text = account.accountName
        accountBalanceLabel.text = Formatters.formatAsCurrency(double: account.statementBalance)
        accountBalanceLabel.textColor = account.statementBalance.expressiveColor
        accountBalanceDescLabel.text = "available balance"
        donateActivity(accountName: account.accountName)
    }

    fileprivate func donateActivity(accountName: String) {
        userActivity = NSUserActivity.viewAccountActivity(accountName: accountName)
    }
}

extension AccountDetailsViewController: UITableViewDelegate {
}

extension AccountDetailsViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TransactionTableViewCell else {
            return UITableViewCell()
        }
        let transaction = dataSource[indexPath.row]
        cell.configure(with: transaction)
        return cell
    }

    func tableView(_: UITableView, willSelectRowAt _: IndexPath) -> IndexPath? {
        return nil
    }
}
