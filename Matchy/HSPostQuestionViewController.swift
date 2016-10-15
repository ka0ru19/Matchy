//
//  HSPostQuestionViewController.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/09.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

// 1/2-1/3.任意の選択肢を元画面のtextfieldにinputするのに使う
protocol InputPostTextDelegate: class {
    func inputPostText(index index: Int, inputText: String)
}

class HSPostQuestionViewController: UIViewController {
    
    @IBOutlet weak var postTableView: UITableView!
    
    let sectionTitleArray = ["質問のタイトル（全角20文字以内）",
                             "質問の内容（全角200文字以内）",
                             "関連するタグ（先頭に＃をつける）",
                             "回答文字数の目安を設定(Default:80文字)",
                             "質問を通知したい大学生を選択(10人以内)",
                             "ベストアンサーへの報酬を設定(3助貨=¥110以上)",
                             "回答期限を設定(3h~72h)"]
    var inputTextArray = ["","","","","","",""]
    
    var selectedSection: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTableView.delegate = self
        postTableView.dataSource = self
        postTableView.registerNib(UINib(nibName: "HSQuestionInputTableViewCell", bundle: nil), forCellReuseIdentifier: "HSQuestionInputCell")
        //        postTableView.estimatedRowHeight = 2000 //CGFloat.max
        //        postTableView.rowHeight = UITableViewAutomaticDimension
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        postTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toInputText" {
            let nextVC = segue.destinationViewController as! HSQuestionInputViewController
            // 2/2-1/2. インスタンス化するタイミングでdelegateをset
            nextVC.inputPostTextDelegate = self
            nextVC.selectedSection = self.selectedSection
            nextVC.sectionLabelText = self.sectionTitleArray[selectedSection]
            nextVC.inputText = inputTextArray[selectedSection]
        }
        else if segue.identifier == "toInputTags" {
            let nextVC = segue.destinationViewController as! HSQuestionInputTagViewController
            // 2/2-1/2. インスタンス化するタイミングでdelegateをset
            nextVC.inputPostTextDelegate = self
            nextVC.selectedSection = self.selectedSection
            nextVC.inputText = inputTextArray[selectedSection]
        }else if segue.identifier == "toSelectUnivUser" {
            let nextVC = segue.destinationViewController as! HSQuestionSelectUnivUserViewController
            // 2/2-1/2. インスタンス化するタイミングでdelegateをset
            nextVC.inputPostTextDelegate = self
            nextVC.selectedSection = self.selectedSection
            nextVC.inputText = inputTextArray[selectedSection]
        }
        else if segue.identifier == "toSetUnivUser" {
            let nextVC = segue.destinationViewController as! HSSetUnivUserViewController
            // 2/2-1/2. インスタンス化するタイミングでdelegateをset
            // nextVC.inputPostTextDelegate = self
            
        }
    }
    
    @IBAction func onDoneButtonTapped(sender: UIButton) {
        performSegueWithIdentifier("toSetUnivUser", sender: nil)
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
        case 6: performSegueWithIdentifier("toInputText", sender: nil)
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

// 2/2-2/2.任意のquestionをtableviewから削除するのに使う
extension HSPostQuestionViewController: InputPostTextDelegate {
    func inputPostText(index index: Int, inputText: String){
        inputTextArray[index] = inputText
    }
}

