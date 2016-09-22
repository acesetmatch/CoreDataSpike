//
//  TreatmentHistoryTableViewCell.swift
//  TestCoreDataLayer
//
//  Created by Gene Backlin on 9/21/16.
//  Copyright © 2016 Gene Backlin. All rights reserved.
//

import UIKit

class TreatmentHistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
