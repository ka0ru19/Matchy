//
//  AuthHSUserViewController.swift
//  Matchy
//
//  Created by 井上航 on 2016/09/24.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class AuthHSUserViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var newMailTextField: UITextField!
    @IBOutlet weak var newPassTextField: UITextField!
    @IBOutlet weak var newPass2TextField: UITextField!
    @IBOutlet weak var agreementMessageTextView: UITextView!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var userMailTextField: UITextField!
    @IBOutlet weak var userPassTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUIParts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initUIParts() {
        newMailTextField.delegate = self
        newMailTextField.tag = 1
        newMailTextField.attributedPlaceholder = NSAttributedString(
            string:"メールアドレス",
            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        
        newPassTextField.delegate = self
        newPassTextField.tag = 2
        newPassTextField.attributedPlaceholder = NSAttributedString(
            string:"パスワード(6~20字)",
            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        
        newPass2TextField.delegate = self
        newPass2TextField.tag = 3
        newPass2TextField.attributedPlaceholder = NSAttributedString(
            string:"パスワード(再入力)",
            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        
        agreementMessageTextView.userInteractionEnabled = true
        agreementMessageTextView.editable = false
        agreementMessageTextView.selectable = true
        
        let text = "Swiftでテキスト内リンク&テキストタップ検出"
        let linkText = "リンク"
        let nsTex = text as NSString
        let link = text.rangeOfString(linkText)
        let attributedString = NSMutableAttributedString(string: text)
        
        // 不明2016/09/24 3:04
//        let start = distance(text.startIndex, link!.startIndex)
//        let length = distance(link!.startIndex, link!.endIndex)
        
        // リンク位置範囲生成
//        range = NSMakeRange(start, length)
        
        signUpButton.layer.cornerRadius = signUpButton.bounds.size.height / 2
        signUpButton.layer.borderWidth = 0.5
        signUpButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        userMailTextField.delegate = self
        userMailTextField.tag = 4
        userMailTextField.attributedPlaceholder = NSAttributedString(
            string:"メールアドレス",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        
        userPassTextField.delegate = self
        userPassTextField.tag = 5
        userPassTextField.attributedPlaceholder = NSAttributedString(
            string:"パスワード",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        
        signInButton.layer.cornerRadius = signUpButton.bounds.size.height / 2
        signInButton.layer.borderWidth = 0.5
        signInButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    
}

extension AuthHSUserViewController: UITextFieldDelegate {
    
}