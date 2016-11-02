//
//  HSPostQuestionViewController.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/09.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit
import Firebase

class HSPostQuestionViewController: UIViewController {
    
    @IBOutlet weak var postTableView: UITableView!
    
    let sectionTitleArray = ["質問のタイトル（全角20文字以内）",
                             "質問の内容（全角200文字以内）",
                             "関連するタグ（先頭に＃をつける）",
                             "回答文字数の目安を設定(Default:80文字)",
                             "質問を通知したい大学生を選択(10人以内)",
                             "ベストアンサーへの報酬を設定(30助貨=¥110以上)",
                             "回答期限を設定(format: 2016/11/02 03:10 3h~72h)"]
    var inputTextArray = ["","","","","","",""]
    
    var selectedSection: Int!
    
    var user = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUser()
        
        postTableView.delegate = self
        postTableView.dataSource = self
        postTableView.registerNib(UINib(nibName: "HSQuestionInputTableViewCell", bundle: nil), forCellReuseIdentifier: "HSQuestionInputCell")
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        postTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initUser() {
        if let user = UserDelegate.user {
            self.user = user
        } else {
            if UserDelegate.isReading {
                print("レスポンス待ち")
            } else {
                print("読み込みしていい")
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toInputText" {
            
            let nextVC = segue.destinationViewController as! InputTextViewController
            // 2/2-1/2. インスタンス化するタイミングでdelegateをset
            nextVC.inputTextDelegate = self
            nextVC.selectedSection = self.selectedSection
            nextVC.sectionLabelText = self.sectionTitleArray[selectedSection]
            nextVC.inputText = inputTextArray[selectedSection]
            
        }else if segue.identifier == "toInputTags" {
            
            let nextVC = segue.destinationViewController as! InputTagViewController
            nextVC.inputTagDelegate = self
            nextVC.selectedSection = self.selectedSection
            nextVC.inputText = inputTextArray[selectedSection]
            
        }else if segue.identifier == "toSelectUnivUser" {
            
            let nextVC = segue.destinationViewController as! HSQuestionSelectUnivUserViewController
            nextVC.inputTextDelegate = self
            nextVC.selectedSection = self.selectedSection
            nextVC.inputText = inputTextArray[selectedSection]
            
        }else if segue.identifier == "toInputDate" {
            
            let nextVC = segue.destinationViewController as! InputDateViewController
            nextVC.inputDateDelegate = self
            nextVC.selectedSection = self.selectedSection
            nextVC.inputDateString = inputTextArray[selectedSection]
            
        }else if segue.identifier == "toQuestionFinish" {
            
            print("質問完了: segue == toQuestionFinish ")
            
        }
    }
    
    @IBAction func onDoneButtonTapped(sender: UIButton) {
        
        if checkAndPostQuestion() {
            performSegueWithIdentifier("toQuestionFinish", sender: nil)
        } else {
            print("post失敗")
        }
    }
    
    func checkAndPostQuestion() -> Bool {
        
        for text in inputTextArray {
            if text.removeAnySpace == "" {
                print("未入力な項目があります")
                return false
            }
        }
        
        let question = QuestionModel()

        question.fromUid = user.uid
        question.toUidArray = inputTextArray[4].makeArrayBySpace
        question.title = inputTextArray[0]
        question.detail = inputTextArray[1]
        question.date = NSDate().getNowDateString
        question.deadline = inputTextArray[6]
        question.tagArray = inputTextArray[2].makeArrayBySpace
        question.answerArray = []
        question.isFinish = false
        question.taskca = inputTextArray[5]
        
        question.post(self.user)
        
        return true
    }
    
}
extension HSPostQuestionViewController: UITableViewDelegate, UITableViewDataSource {
    
    // セクションの数を返す.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionTitleArray.count
    }
    
    // セクションのタイトルを返す
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitleArray[section]
    }
    
    // セクションの高さを指定
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    // セルの高さを返す
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 1: return 120 // 質問の内容のcellだけ多めのheight
        default: return 40
        }
    }
    
    // Cellが選択された際に呼び出される.
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedSection = indexPath.section
        switch selectedSection {
        case 0: performSegueWithIdentifier("toInputText", sender: nil)
        case 1: performSegueWithIdentifier("toInputText", sender: nil)
        case 2: performSegueWithIdentifier("toInputTags", sender: nil)
        case 3: performSegueWithIdentifier("toInputText", sender: nil)
        case 4: performSegueWithIdentifier("toSelectUnivUser", sender: nil)
        case 5: performSegueWithIdentifier("toInputText", sender: nil)
        case 6: performSegueWithIdentifier("toInputDate", sender: nil)
        default: fatalError()
        }
        //        performSegueWithIdentifier("toInput", sender: nil)
        
    }
    
    // テーブルに表示する配列の総数を返す.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Cellに値を設定する.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HSQuestionInputCell") as! HSQuestionInputTableViewCell
        
        cell.setCell(labelText: inputTextArray[indexPath.section])
        
        return cell
    }
    
    
}

// 2/2-2/2.textをnextVCから編集するのに使う
extension HSPostQuestionViewController: InputTextDelegate {
    func inputText(index index: Int, inputText: String){
        inputTextArray[index] = inputText
    }
}

// 2/2-2/2.tagをnextVCから編集するのに使う
extension HSPostQuestionViewController: InputTagDelegate {
    func inputTag(index index: Int, inputTagText: String){
        inputTextArray[index] = inputTagText
    }
}

extension HSPostQuestionViewController: InputDateDelegate {
    func inputDate(index index: Int, inputDateString: String) {
        inputTextArray[index] = inputDateString
    }
}
