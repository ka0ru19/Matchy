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
    
    var range1: NSRange!
    var range2: NSRange!
    
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
        
        let text = "登録すると利用規約とプライバシーポリシーに同意したとみなします。"
        let linkText1 = "利用規約"
        let linkText2 = "プライバシーポリシー"
        let nsTex = text as NSString // テキスト全体
        let link1 = text.rangeOfString(linkText1)
        let link2 = text.rangeOfString(linkText2)
        let attributedString = NSMutableAttributedString(string: text)
        let start1 = text.startIndex.distanceTo(link1!.startIndex)
        let length1 = link1!.startIndex.distanceTo(link1!.endIndex)
        range1 = NSMakeRange(start1, length1) // リンク位置範囲生成
        
        let start2 = text.startIndex.distanceTo(link2!.startIndex)
        let length2 = link2!.startIndex.distanceTo(link2!.endIndex)
        range2 = NSMakeRange(start2, length2) // リンク位置範囲生成
        
        // テキスト全体文字色
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: NSMakeRange(0, nsTex.length))
        attributedString.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(11) , range: NSMakeRange(0, nsTex.length))
        
        // リンク1: カラー, 下線
        attributedString.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(11), range: range1)
        attributedString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: range1)
        
        // リンク2: カラー, 下線
        attributedString.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(11), range: range2)
        attributedString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: range2)
        
        // 属性を代入
        agreementMessageTextView.attributedText = attributedString
        
        // gesture追加
        let tap = UITapGestureRecognizer(target: self, action: "tapLinkText:")
        agreementMessageTextView.addGestureRecognizer(tap)
        
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
    
    func tapLinkText(tap: UITapGestureRecognizer) {
        
        // タップされた座標をもとに最寄りの文字列の位置を取得
        let location = tap.locationInView(agreementMessageTextView)
        let textPosition = agreementMessageTextView.closestPositionToPoint(location)
        
        // テキストの先頭とタップした文字の距離をNSIntegerで取得
        let selectedPosition = agreementMessageTextView.offsetFromPosition(agreementMessageTextView.beginningOfDocument, toPosition: textPosition!)
        
        // タップした文字がリンク文字のrangeに含まれるか判定
        if NSLocationInRange(selectedPosition, range1) { // リンクタップ時の処理
            performSegueWithIdentifier("toTermOfService", sender: nil)
        } else if NSLocationInRange(selectedPosition, range2) { // リンクタップ時の処理
            performSegueWithIdentifier("toPrivacyPolicy", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    
}

extension AuthHSUserViewController: UITextFieldDelegate {
    
}