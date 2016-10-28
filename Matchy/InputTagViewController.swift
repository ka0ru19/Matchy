//
//  InputTagViewController.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/20.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

// 1/2-1/3.任意の選択肢を元画面のtextfieldにinputするのに使う
protocol InputTagDelegate: class {
    func inputTag(index index: Int, inputTagText: String)
}


class InputTagViewController: UIViewController {
    
    // 1/2-2/3. delegateの設定
    var inputTagDelegate: InputTagDelegate?
    var selectedSection: Int!
    var inputText: String! // viewDidLoadでスペース埋めして配列に格納してくれる
    
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var tagTableView: UITableView!
    @IBOutlet weak var inputBarView: UIView!
    @IBOutlet weak var sharpLabel: UILabel!
    @IBOutlet weak var inputTagTextField: UITextField!
    @IBOutlet weak var addTagButton: UIButton!
    
    var tagsArray = [String]() // ["タグ名1","タグ名2","タグ名3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initTagArrayFromInputText()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        if tagsArray.count > 0 {
            var inputHashListText = ""
            for tag in tagsArray {
                inputHashListText += "#" + tag + " "
            }
            // 1/2-3/3. 元画面にこの質問を選択肢を再登録
            self.inputTagDelegate?.inputTag(index: selectedSection, inputTagText: inputHashListText)
        } else {
            print("未入力")
            // 1/2-3/3. 元画面にこの質問を選択肢を再登録
            self.inputTagDelegate?.inputTag(index: selectedSection, inputTagText: "")
        }
    }
    
    // 2.送られてきたNSNotificationを処理して、キーボードの高さを取得する
    func showKeyboard(notification:NSNotification){
        
        if let userInfo = notification.userInfo{
            if let keyboard = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue{
                let keyBoardRect = keyboard.CGRectValue()
                
                print(keyBoardRect.height)
                NSLog("\(keyBoardRect.size.height)")
            }
        }
    }
    
    func initView() {
        
        tagTableView.delegate = self
        tagTableView.dataSource = self
        inputTagTextField.delegate = self
        inputTagTextField.returnKeyType = .Done
        
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        let navigationControllerBarHeight = self.navigationController?.navigationBar.frame.size.height
        var keyboardHeight: CGFloat!
        
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height
        
        var rect: CGRect!
        // 1.キーボード表示する際に送られるNSNotificationを受け取るための処理を追加
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "showKeyboard:", name: UIKeyboardDidShowNotification, object: nil)
        
        inputTagTextField.becomeFirstResponder() // キーボード呼び出し
        
        // 2.送られてきたNSNotificationを処理して、キーボードの高さを取得する
        func showKeyboard(notification:NSNotification){
            
            if let userInfo = notification.userInfo{
                if let keyboard = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue{
                    keyboardHeight = keyboard.CGRectValue().height
                    
                    rect = CGRectMake(0, screenHeight - keyboardHeight, screenWidth, 40)
                    inputBarView.drawRect(rect)
                    
                    let margin: CGFloat = 20
                    
                    let startY = statusBarHeight + navigationControllerBarHeight! + margin
                    rect = CGRectMake(margin, startY,
                                      screenWidth - margin * 3,
                                      screenHeight - keyboardHeight - startY)
                    tagTableView.drawRect(rect)
                }
            }
        }
        
    }
    @IBAction func onTappedAddTagButton() {
        checkAndAddTagToArray()
    }
    
    // 前のviewから引き継いだtextを操作して配列に格納
    func initTagArrayFromInputText() {
        
        // 空白を埋めて、#で区切って配列に格納
        let array = inputText
            .stringByReplacingOccurrencesOfString(" ", withString: "")
            .componentsSeparatedByString("#")
        
        for tag in array {
            if tag != "" {
                tagsArray.append(tag)
            }
        }
        
        tagTableView.reloadData()
    }
    
    func checkAndAddTagToArray() {
        
        guard let text = inputTagTextField.text else {
            if tagsArray.count > 0 {
                self.navigationController?.popViewControllerAnimated(true)
            } else {
                print("１つ以上のタグを入力してください")
            }
            return
        }
        
        // スペースを埋める処理をここに書く
        let hashText = text.stringByReplacingOccurrencesOfString(" ", withString: "")
        // #があったら除去
        if hashText != "" {
            tagsArray.append(hashText)
            tagTableView.reloadData()
        } else {
            print("空白は不可")
        }
        
        inputTagTextField.text = ""
    }
}

extension InputTagViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        checkAndAddTagToArray()
        return true
    }
}



extension InputTagViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tagsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = "#" + tagsArray[indexPath.row]
        
        return cell
    }
    
    // スワイプで削除を許可
    func tableView(tableView: UITableView,canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // スワイプ->削除ボタンが押されたら
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle,
                   forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            tagsArray.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
}
