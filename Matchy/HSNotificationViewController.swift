//
//  HSNotificationViewController.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/10.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class HSNotificationViewController: UIViewController {
    
    @IBOutlet weak var notificationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.items?[3].badgeValue = "3"
        
        notificationTableView.delegate = self
        notificationTableView.dataSource = self
        notificationTableView.registerNib(UINib(nibName: "HSNotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "HSNotificationCell")
        notificationTableView.estimatedRowHeight = 2000 //CGFloat.max
        notificationTableView.rowHeight = UITableViewAutomaticDimension
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension HSNotificationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HSNotificationCell") as! HSNotificationTableViewCell
        cell.iconImageView.image = UIImage(named: "new_black.png")
        cell.titleLabel.text = "新しい通知その\(indexPath.row)!"
        return cell
    }
}
