//
//  HSUnivUserTableViewCell.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/09.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class HSUnivUserTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageVIew: UIImageView!
    @IBOutlet weak var userIdLabal: UILabel!
    @IBOutlet weak var userUnivLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    func setCell() {
        
    }
}
