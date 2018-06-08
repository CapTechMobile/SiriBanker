//
//  AccountDetailsViewController.swift
//  SiriBanker
//
//  Created by Allen White on 6/8/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import UIKit

class AccountDetailsViewController: UIViewController {
    @IBOutlet var topBackgroundView: UIView!
    @IBOutlet var accountTypeLabel: UILabel!
    @IBOutlet var accountNumberLabel: UILabel!
    @IBOutlet var accountBalanceLabel: UILabel!
    @IBOutlet var accountBalanceDescLabel: UILabel!
    @IBOutlet var tableView: UITableView!

    var account: Account?
    fileprivate let cellIdentifier = "TransactionTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension AccountDetailsViewController: UITableViewDelegate {
}

extension AccountDetailsViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return account?.transactions.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TransactionTableViewCell, let transaction = account?.transactions[indexPath.row] else {
            return UITableViewCell()
        }
        cell.amountLabel.text = "$\(transaction.amount)"
        cell.dateLabel.text = "\(transaction.date)"
        cell.memoLabel.text = transaction.memo
        return cell
    }
}
