//
//  HSQestionDetailUnivAnswerTableViewCell.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/09.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class HSQestionDetailUnivAnswerTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var univLabel: UILabel!
    @IBOutlet weak var univUserButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rankImageView: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var rankButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(answer: AnswerModel) {
        let fixedWidth = answerLabel.frame.size.width
        let newSize = answerLabel.sizeThatFits(CGSizeMake(fixedWidth, CGFloat.max))
        var newFrame = answerLabel.frame
        newFrame.size = CGSizeMake(max(newSize.width, fixedWidth), newSize.height)
        answerLabel.frame = newFrame
        
//        iconImageView.image = 
        nameLabel.text = answer.userName
//        univLabel.text = 
        dateLabel.text = answer.date
//        rankImageView.image = 
        answerLabel.text = answer.message
        
    }
}
