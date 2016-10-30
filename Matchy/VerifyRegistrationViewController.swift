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
        user.registerHS()
        
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setObject("true", forKey: "isDoneRegistHS")
        
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
