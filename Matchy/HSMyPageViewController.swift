//
//  HSMyPageViewController.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/10.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class HSMyPageViewController: UIViewController {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    
    var user = UserModel()
    let ud = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.user = UserDelegate.user!
        
        initView()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        iconImageView.image = user.icon
        userIdLabel.text = user.id
        userNameLabel.text = user.name
        introLabel.text = user.intro
        tagsLabel.text = user.tagArray.joinWithSeparator(" ")
    }
    
    @IBAction func onTappedLogoutButton() {
        verifyLogoutAlert()
    }
    
    func verifyLogoutAlert() {
        let alert = UIAlertController(title: "確認", message: "ログアウトします", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler:{
            (action: UIAlertAction!) -> Void in
            self.logout()
        })
        let cancelAction = UIAlertAction(title: "キャンセル", style: .Cancel, handler:{
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // 疑似ログアウト, iPhoneからログイン情報を消す
    func logout() {
        UserDelegate.user = nil
        ud.setObject(nil, forKey: "uid")
        performSegueWithIdentifier("toTop", sender: nil)
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
