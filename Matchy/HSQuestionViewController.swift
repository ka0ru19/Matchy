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
    
    var isFirstReadView = true
    
    let ud = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user.firReadUserFinishDelegate = self
        
        initUser()
        
        hsQuestionTableView.delegate = self
        hsQuestionTableView.dataSource = self
        hsQuestionTableView.registerNib(UINib(nibName: "HSQuestionTableViewCell", bundle: nil), forCellReuseIdentifier: "HSQuestionCell")
        hsQuestionTableView.estimatedRowHeight = 2000 //CGFloat.max
        hsQuestionTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidAppear(animated: Bool) {
        if isFirstReadView {
            isFirstReadView = false
            return
        }
        initQuestionArray(user.uid)
        hsQuestionTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDetail" {
            let nextVC = segue.destinationViewController as! HSQuestionDetailViewController
            nextVC.question = self.selectedQuestion
        }
    }
    func initUser() {
        if let user = UserDelegate.user {
            self.user = user
        } else {
            let uid = ud.objectForKey("uid") as! String
            user.getHSUserFromUid(uid)
        }
    }
    
    func initQuestionArray(uid:String){
        questionArray = []
        user.getQuestionsWithUid(uid, vc: self)
        
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
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedQuestion = questionArray[indexPath.row]
        performSegueWithIdentifier("toDetail", sender: nil)
    }
}


extension HSQuestionViewController: FirReadUserFinishDelegate {
    func readUserFinish(user: UserModel) {
        UserDelegate.user = user
        self.user = user
        initQuestionArray(user.uid)
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



