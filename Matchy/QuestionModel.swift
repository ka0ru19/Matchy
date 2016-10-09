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
    var from: UserModel! // HS
    var to: [UserModel] = []
    var title: String!
    var detail: String!
    var date: String! // 2016/11/03 04:43
    var deadline: String! // 2016/11/06 04:43
    var tagArray: [MatchyTagModel] = []
    var answerArray: [AnswerModel] = []
    var taskca: Int!
}
