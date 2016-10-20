//
//  AuthHSUserViewController.swift
//  Matchy
//
//  Created by 井上航 on 2016/09/24.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthHSUserViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
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
    
    var range1: NSRange!
    var range2: NSRange!
    
    var focusedTextFieldTag: Int!
    //    var lastMoveSize: CGFloat = 0
    
    // 「user」というインスタンスをつくる。
    let ud = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initUIParts()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: "keyboardWillBeShown:",
                                                         name: UIKeyboardWillShowNotification,
                                                         object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: "keyboardWillBeHidden:",
                                                         name: UIKeyboardWillHideNotification,
                                                         object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self,
                                                            name: UIKeyboardWillShowNotification,
                                                            object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self,
                                                            name: UIKeyboardWillHideNotification,
                                                            object: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toSendMail" {
            let nextVC = segue.destinationViewController as! SendEmailVerifyViewController
            // 2/2-1/2. インスタンス化するタイミングでdelegateをset
            nextVC.email = newMailTextField.text
            nextVC.password = newPassTextField.text
        }
    }
    
    @IBAction func onTappedSignUpButton() {
        guard let signUpEmail = newMailTextField.text else {
            print("no email")
            return
        }
        guard let signUpPass = newPassTextField.text else {
            print("no pass")
            return
        }
        guard let pass2 = newPass2TextField.text else {
            print("no pass2")
            return
        }
        if signUpPass != pass2 {
            print("２つのパスワードが一致しません")
            newPassTextField.text = ""
            newPass2TextField.text = ""
            return
        }
        FIRAuth.auth()?.createUserWithEmail(signUpEmail, password: signUpPass, completion: { (user, error) in
            
            //エラーなしなら、認証完了
            if let error = error {
                print("\(error.localizedDescription)")
                return
            }
            
            // メールのバリデーションを行う
            user?.sendEmailVerificationWithCompletion({ (mailError) in
                if mailError == nil {
                    // エラーがない場合にはそのままログイン画面に飛び、ログインしてもらう
                    guard let user = user else { return }
                    
                    print(user.uid)
                    print(user.email)
                    print("user has been signed in successfully.")
                    
                    self.performSegueWithIdentifier("toSendMail", sender: nil)
                    
                }else {
                    print("\(mailError?.localizedDescription)")
                }
            })
            
            
        })
    }
    
    @IBAction func onTappedSignInButton() {
        guard let signInEmail = userMailTextField.text else {
            print("no email")
            return
        }
        guard let signInPass = userPassTextField.text else {
            print("no pass")
            return
        }
        
        FIRAuth.auth()?.signInWithEmail(signInEmail, password: signInPass, completion: {(user:FIRUser?, error:NSError?) in
            if let error = error {
                print("login failed! \(error)")
                return
            }
            
            if let signInUser = user {
                
                // Emailのバリデーションが完了しているか確認する。完了ならそのままログイン
                if signInUser.emailVerified {
                    // 完了済みなら、ListViewControllerに遷移
                    print(FIRAuth.auth()?.currentUser)
                    print(signInUser.uid)
                    print(signInUser.email)
                    print("user has been signed in successfully.")
                    
                    // キーidに「taro」という値を格納。（idは任意の文字列でok）
                    self.ud.setObject(signInUser.uid, forKey: "uid")
                    
                    self.performSegueWithIdentifier("toHSTop", sender: nil)
                    
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
}

// viewの初期化
extension AuthHSUserViewController {
    
    func initUIParts() {
        
        scrollView.delegate = self
        
        newMailTextField.delegate = self
        newMailTextField.tag = 1
        newMailTextField.returnKeyType = .Next
        newMailTextField.attributedPlaceholder = NSAttributedString(
            string:"メールアドレス",
            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        
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
        newPass2TextField.returnKeyType = .Done
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
        
        userMailTextField.delegate = self
        userMailTextField.tag = 4
        userMailTextField.returnKeyType = .Next
        userMailTextField.textColor = UIColor.whiteColor()
        userMailTextField.attributedPlaceholder = NSAttributedString(
            string:"メールアドレス",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        
        userPassTextField.delegate = self
        userPassTextField.tag = 5
        userPassTextField.returnKeyType = .Done
        userPassTextField.textColor = UIColor.whiteColor()
        userPassTextField.keyboardType = .ASCIICapable
        userPassTextField.secureTextEntry = true
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
    
    //    override func scrollViewDidScroll(scrollView: UIScrollView) {
    //
    //        contentOffset = scrollView.contentOffset
    //    }
    
}

extension AuthHSUserViewController: UIScrollViewDelegate {
    
    func keyboardWillBeShown(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue, let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue {
                restoreScrollViewSize()
                
                let convertedKeyboardFrame = scrollView.convertRect(keyboardFrame, fromView: nil)
                let focusedTextField = self.view.viewWithTag(focusedTextFieldTag) as! UITextField
                let offsetY: CGFloat = CGRectGetMaxY(focusedTextField.frame) - CGRectGetMinY(convertedKeyboardFrame)
                let margin: CGFloat = 120
                if offsetY + margin < 0 { return }
                print("textfieldFrameY: \(CGRectGetMaxY(focusedTextField.frame))")
                print("onvertedKeyboardFrame: -\(CGRectGetMinY(convertedKeyboardFrame))")
                print("offsetY: \(offsetY)")
                print("moveSize: \(offsetY + margin)")
                updateScrollViewSize(offsetY + margin, duration: animationDuration)
            }
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        restoreScrollViewSize()
    }
    
    func updateScrollViewSize(moveSize: CGFloat, duration: NSTimeInterval) {
        UIView.beginAnimations("ResizeForKeyboard", context: nil)
        UIView.setAnimationDuration(duration)
        
        let contentInsets = UIEdgeInsetsMake(0, 0, moveSize, 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        scrollView.contentOffset = CGPointMake(0, moveSize)
        
        UIView.commitAnimations()
        
        //                lastMoveSize = moveSize
    }
    
    func restoreScrollViewSize() {
        print("UIEdgeInsetsZero:\(UIEdgeInsetsZero)")
        //        scrollView.contentInset = UIEdgeInsetsZero
        scrollView.scrollIndicatorInsets = UIEdgeInsetsZero
    }
}

// textViewのfocus変更による画面scroll
extension AuthHSUserViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        focusedTextFieldTag = textField.tag
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let nextTextField = nextInputTextField(textField.tag) {
            textField.resignFirstResponder() // focus解除
            nextTextField.becomeFirstResponder() // focus
        } else {
            textField.resignFirstResponder() // focus解除
            // 次の画面に行く準備処理
        }
        return true
    }
    
    // 次の入力に移動するメソッド
    func nextInputTextField(tagNum: Int) -> UITextField? {
        if let nextTextField = self.view.viewWithTag(tagNum + 1) {
            if tagNum == 3 {
                return nil
            } else {
                return nextTextField as? UITextField
            }
        }
        return nil
    }
    
}
