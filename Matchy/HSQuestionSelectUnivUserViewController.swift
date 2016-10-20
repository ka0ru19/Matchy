//
//  HSQuestionSelectUnivUserViewController.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/15.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class HSQuestionSelectUnivUserViewController: UIViewController {
    
    @IBOutlet weak var univUserSearchBar: UISearchBar!
    @IBOutlet weak var univUserTableView: UITableView!
    
    let userCount = 7
    var userIdArray = [String]()
    var isCheckedUserArray = [Bool]()
    
    var selectedSection: Int!
    var inputText: String!
    // 1/2-2/3. delegateの設定
    var inputTextDelegate: InputTextDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initArray()
        
        univUserTableView.delegate = self
        univUserTableView.dataSource = self
        univUserTableView.registerNib(UINib(nibName: "HSQuestionSelectUnivUserTableViewCell", bundle: nil), forCellReuseIdentifier: "questionSelectUnivUserCell")
        univUserTableView.estimatedRowHeight = 2000 //CGFloat.max
        univUserTableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        
        var inputText = ""
        for i in 0 ..< isCheckedUserArray.count {
            if isCheckedUserArray[i] == true {
                inputText += userIdArray[i] + " "
            }
        }
        
        if inputText != "" {
            // 1/2-3/3. 元画面にこの質問を選択肢を再登録
            self.inputTextDelegate?.inputText(index: selectedSection,
                                                      inputText: inputText)
        } else {
            print("未入力")
        }
    }
    
    func initArray() {
        for i in 0 ..< userCount {
            userIdArray.append("qwrtyu-\(i)")
            isCheckedUserArray.append(false)
        }
    }
}

extension HSQuestionSelectUnivUserViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("questionSelectUnivUserCell") as! HSQuestionSelectUnivUserTableViewCell
        
        let model = UserModel()
        cell.setCell(model, isSelected: isCheckedUserArray[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        isCheckedUserArray[indexPath.row] = true
        tableView.reloadData()
    }
}
