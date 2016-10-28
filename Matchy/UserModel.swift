//
//  UserModel.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/09.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import Foundation
import UIKit
import Firebase

// key: "users"

// 1/2-1/3. 読み込みが完了したときのトリガー
protocol FirReadUserFinishDelegate: class {
    func readUserFinish(user: UserModel)
}

class UserModel {
    var uid: String! // login uid
    var id: String! // ~18
    var name: String = ""
    var schoolType: String! // HS OR Univ
    var schoolName: String!
    var schoolGrade: String!
    var schoolDepartment: String! // Univ Only
    var schoolInterest: String! // HS Only
    var schoolClub: String!
    var iconUrl: String = ""
    var icon: UIImage!
    var intro: String = ""
    var tagArray: [String] = []
    var questionIdArray: [String]? = [] // question_id for HS and Univ
    var answerIdArray: [String]? = [] // answer_id for Univ Only
    var taskca: String = "0"
    
    var questionArray = [QuestionModel]()
    var questionIdCount: Int!
    
    // 1/2-2/3. delegateの設定
    var firReadUserFinishDelegate: FirReadUserFinishDelegate?
    
    let userRef = FIRDatabase.database().reference().child("users").child((FIRAuth.auth()?.currentUser?.uid)!)
    
    
    func registerHS() {
        
        let imageData = UIImageJPEGRepresentation(self.icon, 0.8)
        self.iconUrl = imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        
        userRef.setValue([
            "uid": self.uid,
            "id": self.id,
            "name": self.name,
            "schoolType": "HS",
            "schoolName": self.schoolName,
            "schoolGrade": self.schoolGrade,
            "schoolInterest": self.schoolInterest,
            "schoolClub": self.schoolClub,
            "iconUrl": self.iconUrl,
            "intro": self.intro,
            "tagArray": self.tagArray,
            "taskca": String(0)
            ])
        
    }
    
    func getHSUserFromUid(uid: String) {
        
        userRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            print(snapshot.value)
            
            guard let userValue = snapshot.value else{
                print("no user value")
                return
            }
            
            self.uid = uid
            self.id = userValue["id"] as! String
            self.name = userValue["name"] as! String
            self.schoolType = userValue["schoolType"] as! String
            self.schoolName = userValue["schoolName"] as! String
            self.schoolGrade = userValue["schoolGrade"] as! String
            self.schoolInterest = userValue["schoolInterest"] as! String
            self.schoolClub = userValue["schoolClub"] as! String
            self.intro = userValue["intro"] as! String
            self.tagArray = userValue["tagArray"] as! [String]
            self.questionIdArray = userValue["questionIdArray"] as? [String]
            self.answerIdArray = userValue["answerIdArray"] as? [String]
            self.taskca = userValue["taskca"] as! String
            
            self.questionIdCount = self.questionIdArray?.count ?? 0
            
            let base64EncodedString = userValue["iconUrl"] as! String
            self.iconUrl = base64EncodedString
            let imageData = NSData(base64EncodedString: base64EncodedString,
                options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
            self.icon = UIImage(data: imageData!)
            
            // 1/2-3/3.
            self.firReadUserFinishDelegate?.readUserFinish(self)
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        
 
    }
    
    
    func getQuestionsWithUid(uid: String, vc: HSQuestionViewController) {
        // 10件ごとに読み込み したい
        
        userRef.child("questionIdArray").observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            print(snapshot.value)
            
            guard let questionValue = snapshot.value else{
                print("no user value")
                return
            }
            let questionKeyArray = questionValue as! [String]
            
            for questionKey in questionKeyArray {
                let question = QuestionModel()
                question.firReadQuestionFinishDelegate = vc
                question.getWithId(questionKey)
            }
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        

    }
    
    
    static var currentUserUid: String {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            fatalError()
        }
        return uid
    }
    
}
