//
//  HSSearchUnivUserViewController.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/09.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class HSSearchUnivUserViewController: UIViewController {
    
    @IBOutlet var univUserSearchBar: UISearchBar!
    @IBOutlet var searchResultTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        searchResultTableView.registerNib(UINib(nibName: "HSUnivUserTableViewCell", bundle: nil), forCellReuseIdentifier: "HSUnivUserCell")
        searchResultTableView.estimatedRowHeight = 2000 //CGFloat.max
        searchResultTableView.rowHeight = UITableViewAutomaticDimension
    
        
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

extension HSSearchUnivUserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HSUnivUserCell") as! HSUnivUserTableViewCell
        
        cell.setCell()
        return cell
    }
}
