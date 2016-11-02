//
//  VerifyRegistrationViewController.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/17.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class VerifyRegistrationViewController: UIViewController {
    
    var user: UserModel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var introTextView: UITextView!
    @IBOutlet weak var tagsTextView: UITextView!
    
    let ud = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconImageView.image = user.icon
        idLabel.text = user.id
        nameLabel.text = user.name
        introTextView.text = user.intro
        tagsTextView.text = user.tagArray.joinWithSeparator(" ")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTappedFinishButton() {
        user.registerHS(self)
        
    }
    
    // 登録Request送信後のレスポンス
    func finishRegister(error error: NSError?) {
        if let error = error {
            print(error)
            return
        }
        
        ud.setObject(user.uid, forKey: "uid")
        ud.setObject("true", forKey: "isDoneRegistHS")
        
        performSegueWithIdentifier("toFinishRegister", sender: nil)
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    
}
