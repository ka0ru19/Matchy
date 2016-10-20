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
    
    var selectedQuestion: QuestionModel!
    
    var questionArray = [QuestionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initQuestionArray()
        
        hsQuestionTableView.delegate = self
        hsQuestionTableView.dataSource = self
        hsQuestionTableView.registerNib(UINib(nibName: "HSQuestionTableViewCell", bundle: nil), forCellReuseIdentifier: "HSQuestionCell")
        hsQuestionTableView.estimatedRowHeight = 2000 //CGFloat.max
        hsQuestionTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(animated: Bool) {
        hsQuestionTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDetail" {
            
        }
    }
    
    func initQuestionArray() {
        
    }
    
}

extension HSQuestionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 //てきとー、あとで直す
    }
    
    // セルに値を設定するデータソースメソッド（必須）
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // セルを取得
        let cell = tableView.dequeueReusableCellWithIdentifier("HSQuestionCell") as! HSQuestionTableViewCell
        
        // セルに値を設定
        cell.setCell()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("toDetail", sender: nil)
    }
}
