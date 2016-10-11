//
//  HSPostQuestionViewController.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/09.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class HSPostQuestionViewController: UIViewController {
    
    @IBOutlet weak var postTableView: UITableView!
    
    let sectionTitleArray = ["質問のタイトル（全角28文字以内）",
                             "質問の内容（全角200文字以内）",
                             "関連するタグ（先頭に＃をつける）"]
    var inputTextArray = ["","",""]
    
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
        if segue.identifier == "toInput" {
            let nextVC = segue.destinationViewController as! HSQuestionInputViewController
            // 2/2-1/2. インスタンス化するタイミングでdelegateをset
            nextVC.inputPostTextDelegate = self
            nextVC.selectedSection = self.selectedSection
            nextVC.inputText = inputTextArray[selectedSection]
        } else if segue.identifier == "toSetUnivUser" {
            let nextVC = segue.destinationViewController as! HSSetUnivUserViewController
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
        case 0: return 50
        case 1: return 250
        case 2: return 50
        default: return 0
        }
    }
    
    // Cellが選択された際に呼び出される.
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedSection = indexPath.section
        performSegueWithIdentifier("toInput", sender: nil)
        
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

