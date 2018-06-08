//
//  AccountsSummaryTableViewCell.swift
//  SiriBanker
//
//  Created by Allen White on 6/8/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import UIKit

class AccountsSummaryTableViewCell: UITableViewCell {
    @IBOutlet var gradientView: UIView!
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
}
