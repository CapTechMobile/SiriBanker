//
//  AccountsSummaryViewController.swift
//  SiriBanker
//
//  Created by Allen White on 6/8/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import SiriBankerKit
import UIKit

class AccountsSummaryViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    fileprivate let cellIdentifier = "AccountsSummaryTableViewCell"
    fileprivate let dataSource = customer!.accounts

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
}

extension AccountsSummaryViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AccountsSummaryTableViewCell else {
            return UITableViewCell()
        }
        let account = dataSource[indexPath.row]
        cell.configure(with: account)
        return cell
    }
}

extension AccountsSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let account = dataSource[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailsView = storyboard.instantiateViewController(withIdentifier: "AccountDetailsViewController") as? AccountDetailsViewController else {
            return
        }
        detailsView.account = account
        navigationController?.pushViewController(detailsView, animated: true)
    }
}
