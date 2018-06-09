//
//  AccountsSummaryTableViewCell.swift
//  SiriBanker
//
//  Created by Allen White on 6/8/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import SiriBankerKit
import UIKit

class AccountsSummaryTableViewCell: UITableViewCell {
    @IBOutlet var accountTypeLabel: UILabel!
    @IBOutlet var accountBalanceLabel: UILabel!
    @IBOutlet var accountNumberLabel: UILabel!
    @IBOutlet var accountBalanceDescriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with account: Account) {
        let currencyFormatter = Formatters.currencyFormatter
        accountTypeLabel.text = account.accountType.rawValue
        accountNumberLabel.text = account.accountName
        accountBalanceLabel.text = currencyFormatter.string(from: NSNumber(value: account.statementBalance))
        accountBalanceDescriptionLabel.text = "available balance"
    }
}
