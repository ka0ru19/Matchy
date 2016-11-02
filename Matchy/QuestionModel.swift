//
//  QuestionModel.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/09.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import Foundation
import UIKit
import Firebase

// 1/2-1/3. 読み込みが完了したときのトリガー
protocol FirReadQuestionFinishDelegate: class {
    func readQuestionFinish(question: QuestionModel)
}

// key: "questionList"
class QuestionModel {
    var id: String!
    var fromUid: String! // HS
    var toUidArray: [String] = [] // 通知したい大学生userIdArray
    var title: String!
    var detail: String!
    var date: String! // 2016/11/03 04:43
    var deadline: String! // 2016/11/06 04:43
    var tagArray: [String] = []
    var answerArray: [String] = [] // AnswerID array
    var isFinish = false
    var taskca: String!
    var timestamp: String!
    
    var firReadQuestionFinishDelegate: FirReadQuestionFinishDelegate?
    
    let questionRef = FIRDatabase.database().reference().child("testquestionList")
    
    func post(user: UserModel){
        let newPostRef = questionRef.childByAutoId()
        
        newPostRef.setValue([
            "id": newPostRef.key,
            "fromUid":self.fromUid,
            "toUidArray":self.toUidArray,
            "title":self.title,
            "detail":self.detail,
            "date":self.date,
            "deadline":self.deadline,
            "tagArray":self.tagArray,
            "isFinish":self.isFinish,
            "taskca":self.taskca,
            "timestamp": FIRServerValue.timestamp()
            ])
        
        let userRef = FIRDatabase.database().reference().child("users").child(self.fromUid)
        
//        userRef.child("questionIdArray").observeEventType(.Value, withBlock: { snapshot in
//            guard let question = snapshot.value else {
//                print("no snapshot.value")
//                return
//            }
//            
            userRef.child("questionIdArray").child(String(user.questionIdCount)).setValue(newPostRef.key)
//        })
        
    }
    
    // 質問単体をread
    func getWithId(questionId: String) {
        print("getWithId: questionIdからquestionを取得開始")
        
        questionRef.child(questionId).observeEventType(.Value, withBlock: { snapshot in
            print("getWithId: questionIdからquestionを取得完了")
            
            guard let questionValue = snapshot.value else {
                print("no question value")
                return
            }
            
            let question = QuestionModel().parseQuestionFromSnapshot(questionValue)
            
            self.firReadQuestionFinishDelegate?.readQuestionFinish(question)
            
        })
    }
    
    func parseQuestionFromSnapshot(value: AnyObject) -> QuestionModel {
        
        let question = QuestionModel()
        let snapshotValue = value
        
        question.id = snapshotValue["id"] as! String
        question.fromUid = snapshotValue["fromUid"] as! String
        question.toUidArray = snapshotValue["toUidArray"] as! [String]
        question.title = snapshotValue["title"] as! String
        question.detail = snapshotValue["detail"] as! String
        question.date = snapshotValue["date"] as! String
        question.deadline = snapshotValue["deadline"] as! String
        question.tagArray = snapshotValue["tagArray"] as! [String]
        question.isFinish = snapshotValue["isFinish"] as! Bool
        question.taskca = snapshotValue["taskca"] as! String
        
        return question
    }
}


