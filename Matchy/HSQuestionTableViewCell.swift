//
//  HSQuestionTableViewCell.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/08.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class HSQuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var univUserLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var questionTitleTextView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setCell() {
        self.accessoryType = .DisclosureIndicator
    }
}
