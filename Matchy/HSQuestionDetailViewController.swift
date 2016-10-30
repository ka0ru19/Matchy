//
//  HSQuestionDetailViewController.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/09.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class HSQuestionDetailViewController: UIViewController {
    
    @IBOutlet var hsQuestionDetailTableView: UITableView!
    
    var question: QuestionModel!
    var answerArray: [AnswerModel] = []
    
    let answerText = "中央大学理工学部に通ってるWataruです。やっぱり、課題は多いですね。毎週15枚のレポートを書かないといけなかったり、実験があったりします。なので、授業出て課題やってバイト週2で入ると、それでほとんど時間埋まっちゃますね。こんな感じで大丈夫？"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hsQuestionDetailTableView.delegate = self
        hsQuestionDetailTableView.dataSource = self
        hsQuestionDetailTableView.registerNib(UINib(nibName: "HSQestionDetailUnivAnswerTableViewCell", bundle: nil),
                                              forCellReuseIdentifier: "AnswerCell")
        hsQuestionDetailTableView.registerNib(UINib(nibName: "HSQestionDetailTopTableViewCell", bundle: nil),
                                              forCellReuseIdentifier: "HSQestionDetailTopCell")
        hsQuestionDetailTableView.estimatedRowHeight = 2000 //CGFloat.max
        hsQuestionDetailTableView.rowHeight = UITableViewAutomaticDimension
        
        hsQuestionDetailTableView.allowsSelection = false
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        hsQuestionDetailTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension HSQuestionDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + answerArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // セルを取得
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("HSQestionDetailTopCell") as! HSQestionDetailTopTableViewCell
            // セルに値を設定
            cell.setCell(question)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("AnswerCell") as! HSQestionDetailUnivAnswerTableViewCell
            // セルに値を設定
            cell.setCell(answerArray[indexPath.row - 1])
            return cell
        }
    }
    
    
}
