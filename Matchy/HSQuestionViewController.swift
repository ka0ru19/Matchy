//
//  HSQuestionViewController.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/09.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class HSQuestionViewController: UIViewController {
    
    @IBOutlet var hsQuestionTableView: UITableView!
    
    var user = UserModel()
    
    var selectedQuestion: QuestionModel!
    
    var questionArray = [QuestionModel]()
    
    let ud = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user.firReadUserFinishDelegate = self
        
//        initUserAndQuestionArray()
        
        hsQuestionTableView.delegate = self
        hsQuestionTableView.dataSource = self
        hsQuestionTableView.registerNib(UINib(nibName: "HSQuestionTableViewCell", bundle: nil), forCellReuseIdentifier: "HSQuestionCell")
        hsQuestionTableView.estimatedRowHeight = 2000 //CGFloat.max
        hsQuestionTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(animated: Bool) {
        initUserAndQuestionArray()
        hsQuestionTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDetail" {
            
        }
    }
    func initUserAndQuestionArray() {
        let uid = ud.objectForKey("uid") as! String
        questionArray = []
        user.getHSUserFromUid(uid)
    }
    
}

extension HSQuestionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection")
        print(questionArray.count ?? 0)
        return questionArray.count ?? 0
    }
    
    // セルに値を設定するデータソースメソッド（必須）
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HSQuestionCell") as! HSQuestionTableViewCell
        
        cell.setCell(questionArray[indexPath.row])
//        cell.setCellTest()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("toDetail", sender: nil)
    }
}


extension HSQuestionViewController: FirReadUserFinishDelegate {
    func readUserFinish(user: UserModel) {
        UserDelegate.user = user
        user.getQuestionsWithUid(user.uid, vc: self)
    }
}


// 2/2-2/2. 読み込み完了したら
extension HSQuestionViewController: FirReadQuestionFinishDelegate {
    func readQuestionFinish(question: QuestionModel) {
        questionArray.append(question)
        print(questionArray.count)
        for item in questionArray {
            print(item.fromUid)
        }
        hsQuestionTableView.reloadData()
    }
}



