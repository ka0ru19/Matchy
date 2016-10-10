//
//  HSNotificationTableViewCell.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/10.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class HSNotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
