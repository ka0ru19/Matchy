//
//  AnswerModel.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/09.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import Foundation

class AnswerModel {
    var id: String!
    var question_id: String!
    var user: UserModel!
    var date: String!
    var message: String!
    var is_read: Bool = false
    var rank: Int = 0 // 0 or 1~5
}
