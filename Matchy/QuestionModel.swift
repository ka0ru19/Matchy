//
//  QuestionModel.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/09.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import Foundation

class QuestionModel {
    var id: String!
    var fromUid: String! // HS
    var toUids: [String] = [] // 通知したい大学生userIdArray
    var title: String!
    var detail: String!
    var date: String! // 2016/11/03 04:43
    var deadline: String! // 2016/11/06 04:43
    var tagArray: [String] = []
    var answerArray: [String] = [] // AnswerID array
    var taskca: Int!
}
