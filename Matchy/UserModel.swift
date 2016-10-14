//
//  UserModel.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/09.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import Foundation

class UserModel {
    var uid: String! // login uid
    var id: String! // ~18
    var name: String!
    var type: String! // HS OR Univ
    var info_HS: Info_HSModel?
    var info_Univ: Info_UnivModel?
    var icon_url: String!
    var intro: String?
    var tagArray: [MatchyTagModel] = []
    var questionIdArray: [String] = [] // question_id for HS and Univ
    var answerIdArray: [String] = [] // answer_id for Univ Only
    var taskca: Int = 0
}
