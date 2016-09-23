//
//  ViewController.swift
//  Matchy
//
//  Created by 井上航 on 2016/09/24.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class TopBranchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTappedHSButton(sender: UIButton) {
        performSegueWithIdentifier("toAuthHSUser", sender: nil)
    }

    @IBAction func onTappedUnivButton(sender: UIButton) {
        performSegueWithIdentifier("toAuthUnivUser", sender: nil)
    }
    
}

