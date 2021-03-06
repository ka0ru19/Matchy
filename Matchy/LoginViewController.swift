//
//  LoginViewController.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/31.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userMailTextField: UITextField!
    @IBOutlet weak var userPassTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    var user = UserModel()
    
    let ud = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTappedLoginButton() {
        login()
    }
    
    func login() {
        guard let signInEmail = userMailTextField.text else { return }
        guard let signInPass = userPassTextField.text else { return }
        
        user.loginHS(mail: signInEmail, pass: signInPass, vc: self)
    }
    
    func successLogin(uid: String) {
        
        ud.setObject(uid, forKey: "uid")
        ud.setObject("true", forKey: "isDoneRegistHS")
        
        user.firReadUserFinishDelegate = self
        user.getHSUserFromUid(uid)
        
    }
    
    func failureLoing(errorMessage errorMessage: String) {
        print(errorMessage)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toHSTopTab" {
            print("LoginViewController : toHSTopTab -> ")
        } else if segue.identifier == "toUnivTopTab" {
            print("LoginViewController : toUnivTopTab -> ")
        }
    }
    
}

extension LoginViewController: FirReadUserFinishDelegate {
    func readUserFinish(user: UserModel) {
        UserDelegate.user = user
        
        switch user.schoolType {
        case "HS"   : performSegueWithIdentifier("toHSTopTab", sender: nil)
        case "Univ" : performSegueWithIdentifier("toUnivTopTab", sender: nil)
        default : fatalError()
        }
        
    }
}

extension LoginViewController {
    func initView() {
        
        userMailTextField.delegate = self
        userMailTextField.tag = 1
        userMailTextField.returnKeyType = .Next
        userMailTextField.textColor = UIColor.whiteColor()
        userMailTextField.attributedPlaceholder = NSAttributedString(
            string:"メールアドレス",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        userMailTextField.becomeFirstResponder()
        
        userPassTextField.delegate = self
        userPassTextField.tag = 2
        userPassTextField.returnKeyType = .Next
        userPassTextField.textColor = UIColor.whiteColor()
        userPassTextField.keyboardType = .ASCIICapable
        userPassTextField.secureTextEntry = true
        userPassTextField.attributedPlaceholder = NSAttributedString(
            string:"パスワード",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        
        signInButton.layer.cornerRadius = signInButton.bounds.size.height / 2
        signInButton.layer.borderWidth = 0.5
        signInButton.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if let nextTextField = nextInputTextField(textField.tag) {
            
            textField.resignFirstResponder() // focus解除
            nextTextField.becomeFirstResponder() // focus
            
        } else {
            
            login()
        }
        return true
    }
    
    // 次の入力に移動するメソッド
    func nextInputTextField(tagNum: Int) -> UITextField? {
        
        if let nextTextField = self.view.viewWithTag(tagNum + 1) {
            return tagNum >= 2 ? nil : nextTextField as? UITextField
        }
        return nil
    }
    
}
