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

// key: "userList"
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
    var questionIdArray: [String] = [] // question_id for HS and Univ
    var answerIdArray: [String] = [] // answer_id for Univ Only
    var taskca: Int = 0
    
    
    func registerHS() {
        
        let userRef = FIRDatabase.database().reference().child("users").child(self.uid)
        
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
            "taskca": String(0)
            ])
        
    }
    
    func getHSUserFromUid(uid: String) {
        
        let userRef = FIRDatabase.database().reference().child("users").child(uid)
        
        userRef.observeEventType(.Value, withBlock: { snapshot in
            
            guard let userValue = snapshot.value else{
                print("no user value")
                return
            }
            
            let base64EncodedString = userValue["iconUrl"] as! String
            self.iconUrl = base64EncodedString
            let imageData = NSData(base64EncodedString: base64EncodedString,
                options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
            self.icon = UIImage(data: imageData!)
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    
}
