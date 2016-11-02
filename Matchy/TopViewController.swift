//
//  TopViewController.swift
//  Matchy
//
//  Created by 井上航 on 2016/09/24.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTappedHSButton() {
        performSegueWithIdentifier("toNewHSRegister", sender: nil)
    }

    @IBAction func onTappedUnivButton() {
        performSegueWithIdentifier("toAuthUnivUser", sender: nil)
    }
    
    @IBAction func onTappedLoginButton() {
        performSegueWithIdentifier("toLogin", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    
}

