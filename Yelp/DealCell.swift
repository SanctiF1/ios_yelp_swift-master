//
//  DealCell.swift
//  Yelp
//
//  Created by ToanVo on 11/22/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit

class DealCell: UITableViewCell {

    @IBOutlet weak var dealLabel: UILabel!
    @IBOutlet weak var dealSwitch: UISwitch!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
