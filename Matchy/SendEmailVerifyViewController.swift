//
//  SendEmailVerifyViewController.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/16.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit
import FirebaseAuth

class SendEmailVerifyViewController: UIViewController {
    
    var email: String!
    var password: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTappedVerifyButton() {
        
        //signInWithEmailでログイン
        //第一引数にEmail、第二引数にパスワードを取ります
        FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { (user, error) in
            //エラーがないことを確認
            if let error = error {
                print("error: \(error.localizedDescription)")
                return
            }
            if let loginUser = user {
                // Emailのバリデーションが完了しているか確認する。完了ならそのままログイン
                if loginUser.emailVerified {
                    print(FIRAuth.auth()?.currentUser)
                    
                    let ud = NSUserDefaults.standardUserDefaults()
                    ud.setObject(loginUser.uid, forKey: "uid")
                    
                    self.performSegueWithIdentifier("toHSRegistration", sender: nil)
                } else {
                    // 完了していない場合は、アラートを表示
                    self.presentValidateAlert()
                }
                
            }
            
        })
        
    }
    
    // メールのバリデーションが完了していない場合のアラートを表示
    func presentValidateAlert() {
        let alert = UIAlertController(title: "メール認証", message: "メール認証を行ってください", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
