//
//  AnswerModel.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/09.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import Foundation

// key: "answerList"
class AnswerModel {
    var id: String! // answer id
    var questionId: String!
    var userUid: String! // uid
    var userName: String!
    var date: String!
    var message: String!
//    var is_read: Bool = false
    var rank: Int = 0 // 0 or 1~3
    var goodUserIdArray: [String] = [] // いいねした人uidリスト
    var isBestAnswer = false
}
