//
//  QuestionModel.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/09.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import Foundation
import Firebase

// key: "questionList"
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
    var isFinish = false
    var taskca: String!
    
    
    let questionRef = FIRDatabase.database().reference().child("testquestionList")
    
    func post(){
        
        questionRef.child(self.id).setValue([
            "id": self.id,
            "fromUid":self.fromUid,
            "toUids":self.toUids,
            "title":self.title,
            "detail":self.detail,
            "date":self.date,
            "deadline":self.deadline,
            "tagArray":self.tagArray,
            "isFinish":self.isFinish,
            "taskca":self.taskca
            ])
    }
    
    func getWithId(questionId: String) {
        
        questionRef.observeEventType(.Value, withBlock: { snapshot in
            
            guard let question = snapshot.value else {
                print("no snapshot.value")
                return
            }
            
            self.detail = question[questionId]!!["detail"] as! String
            
        })
        //            print("---1")
        //            print(snapshot.value!.count)
        //            count = snapshot.value!.count
        //            if isYet {
        //                isYet = false
        //                targetRef.child(String(count)).setValue(["name":"zore","initial":"ichi","canvas":[["name":"cn","initial":"cinit"]]])
        //            } else {
        //                return
        //            }
        //            
        //        })
        //        
        //        print(count)
    }
    
}


