//
//  NewHSRegisterViewController.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/31.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class NewHSRegisterViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var newMailTextField: UITextField!
    @IBOutlet weak var newPassTextField: UITextField!
    @IBOutlet weak var newPass2TextField: UITextField!
    @IBOutlet weak var agreementMessageTextView: UITextView!
    @IBOutlet weak var signUpButton: UIButton!
    
    var range1: NSRange!
    var range2: NSRange!
    
    let ud = NSUserDefaults.standardUserDefaults()
    
    let user = UserModel()
    
    var agreementIndex : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUIParts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTappedSignUpButton() {
        register()
    }
    
    func register() {
        // それぞれのtextFieldに値が入力されているか確認
        guard let signUpEmail = newMailTextField.text else { return }
        guard let signUpPass = newPassTextField.text else { return }
        guard let pass2 = newPass2TextField.text else { return }
        
        if signUpPass != pass2 {
            
            print("２つのパスワードが一致しません")
            newPassTextField.text = ""
            newPass2TextField.text = ""
            return
        }
        
        user.registerNewHS(mail: signUpEmail, pass: signUpPass, vc: self)
        
    }
    
    func successNewHSRegister() {
        self.performSegueWithIdentifier("toVerifyMail", sender: nil)
    }
    
    func failureNewHSRegister(errorMessage errorMessage: String) {
        print("failureNewHSRegister: \(errorMessage)")
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toVerifyMail" {
            let nextVC = segue.destinationViewController as! SendEmailVerifyViewController
            nextVC.email = newMailTextField.text
            nextVC.password = newPassTextField.text
        } else if segue.identifier == "toAgreement" {
            let nextVC = segue.destinationViewController as! AgreementViewController
            nextVC.index = agreementIndex
        }
    }
    
}

// viewの初期化
extension NewHSRegisterViewController {
    
    func initUIParts() {
        
        newMailTextField.delegate = self
        newMailTextField.tag = 1
        newMailTextField.returnKeyType = .Next
        newMailTextField.attributedPlaceholder = NSAttributedString(
            string:"メールアドレス",
            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        newMailTextField.becomeFirstResponder()
        
        newPassTextField.delegate = self
        newPassTextField.tag = 2
        newPassTextField.returnKeyType = .Next
        newPassTextField.keyboardType = .ASCIICapable
        newPassTextField.secureTextEntry = true
        newPassTextField.attributedPlaceholder = NSAttributedString(
            string:"パスワード(6~20字)",
            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        
        newPass2TextField.delegate = self
        newPass2TextField.tag = 3
        newPass2TextField.returnKeyType = .Next
        newPass2TextField.keyboardType = .ASCIICapable
        newPass2TextField.secureTextEntry = true
        newPass2TextField.attributedPlaceholder = NSAttributedString(
            string:"パスワード(再入力)",
            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        
        agreementMessageTextView.userInteractionEnabled = true
        agreementMessageTextView.editable = false
        agreementMessageTextView.selectable = true //
        
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
        
    }
    
    func tapLinkText(tap: UITapGestureRecognizer) {
        
        // タップされた座標をもとに最寄りの文字列の位置を取得
        let location = tap.locationInView(agreementMessageTextView)
        let textPosition = agreementMessageTextView.closestPositionToPoint(location)
        
        // テキストの先頭とタップした文字の距離をNSIntegerで取得
        let selectedPosition = agreementMessageTextView.offsetFromPosition(agreementMessageTextView.beginningOfDocument, toPosition: textPosition!)
        
        // タップした文字がリンク文字のrangeに含まれるか判定
        if NSLocationInRange(selectedPosition, range1) { // リンクタップ時の処理
            agreementIndex = 0
            performSegueWithIdentifier("toAgreement", sender: nil)
        } else if NSLocationInRange(selectedPosition, range2) { // リンクタップ時の処理
            agreementIndex = 1
            performSegueWithIdentifier("toAgreement", sender: nil)
        }
    }
    
}

extension NewHSRegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if let nextTextField = nextInputTextField(textField.tag) {
            
            textField.resignFirstResponder() // focus解除
            nextTextField.becomeFirstResponder() // focus
            
        } else {
            // 次のvcへ
            register()
            //            textField.resignFirstResponder() // focus解除
            // 次の画面に行く準備処理
            
        }
        return true
    }
    
    // 次の入力に移動するメソッド
    func nextInputTextField(tagNum: Int) -> UITextField? {
        if let nextTextField = self.view.viewWithTag(tagNum + 1) {
            return tagNum >= 3 ? nil : nextTextField as? UITextField
        }
        return nil
    }
    
}
