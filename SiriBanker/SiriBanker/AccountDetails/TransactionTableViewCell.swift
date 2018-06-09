//
//  TransactionTableViewCell.swift
//  SiriBanker
//
//  Created by Allen White on 6/8/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import SiriBankerKit
import UIKit

class TransactionTableViewCell: UITableViewCell {
    @IBOutlet var memoLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with transaction: Transaction) {
        amountLabel.text = Formatters.formatAsCurrency(double: transaction.amount)
        amountLabel.textColor = transaction.amount.expressiveColor
        let prettyDate = Formatters.networkDateFormatter.string(from: transaction.date)
        dateLabel.text = "\(prettyDate)"
        memoLabel.text = transaction.memo
    }
}
