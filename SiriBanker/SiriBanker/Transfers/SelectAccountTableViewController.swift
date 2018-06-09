//
//  SelectAccountTableViewController.swift
//  SiriBanker
//
//  Created by Allen White on 6/9/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import SiriBankerKit
import UIKit

class SelectAccountTableViewController: UITableViewController {
    fileprivate let cellIdentifier = "AccountsSummaryTableViewCell"
    fileprivate let dataSource = customer.remainingAccounts

    var isSelectingToAccount: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in _: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AccountsSummaryTableViewCell else {
            return UITableViewCell()
        }
        let account = dataSource[indexPath.row]
        cell.accountTypeLabel.text = account.accountType.rawValue
        cell.accountNumberLabel.text = account.accountName
        cell.accountBalanceLabel.text = "$\(account.statementBalance)"
        cell.accountBalanceDescriptionLabel.text = "available balance"
        return cell
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let account = dataSource[indexPath.row]
        if isSelectingToAccount {
            customer.toAccount = account
        } else {
            customer.fromAccount = account
        }
        navigationController?.popViewController(animated: true)
    }
}
