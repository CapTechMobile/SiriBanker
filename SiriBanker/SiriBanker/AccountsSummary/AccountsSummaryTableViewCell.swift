//
//  AccountsSummaryTableViewCell.swift
//  SiriBanker
//
//  Created by Allen White on 6/8/18.
//  Copyright © 2018 LBrands. All rights reserved.
//

import UIKit

class AccountsSummaryTableViewCell: UITableViewCell {

	@IBOutlet weak var gradientView: UIView!
	@IBOutlet weak var accountTypeLabel: UILabel!
	@IBOutlet weak var accountBalanceLabel: UILabel!
	@IBOutlet weak var accountNumberLabel: UILabel!
	@IBOutlet weak var accountBalanceDescriptionLabel: UILabel!
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
