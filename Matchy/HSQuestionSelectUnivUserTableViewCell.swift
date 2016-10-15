//
//  HSQuestionSelectUnivUserTableViewCell.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/15.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class HSQuestionSelectUnivUserTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var userIdLabal: UILabel!
    @IBOutlet weak var userUnivLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    
//    var isSelectedUser = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setCell(userModel: UserModel, isSelected :Bool) {
        if isSelected == true {
            checkImageView.image = UIImage(named: "pointing.png")
        } else {
            checkImageView.image = UIImage(named: "add.png")
        }
    }
}
