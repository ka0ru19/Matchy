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
    @IBOutlet weak var questionTitleLabel: UILabel!
//    @IBOutlet weak var nextButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setCell(question: QuestionModel) {
        
        univUserLabel.text = makeOpponentsText(question.toUidArray)
        postDateLabel.text = question.date
        questionTitleLabel.text = question.title
        self.accessoryType = .DisclosureIndicator
    }
    
    
    func setCellTest() {
        self.accessoryType = .DisclosureIndicator
    }
    
    func makeOpponentsText(opponentsArray: [String]) -> String{

        return opponentsArray.joinWithSeparator(",")
        // 後日、要編集
    }
}
