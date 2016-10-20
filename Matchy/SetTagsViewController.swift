//
//  SetTagsViewController.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/17.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class SetTagsViewController: UIViewController {
    
    var user: UserModel!

    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    var buttonArray = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        buttonArray.append(button0)
        buttonArray.append(button1)
        buttonArray.append(button2)
        buttonArray.append(button3)
        buttonArray.append(button4)
        buttonArray.append(button5)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toVerify" {
            let nextVC = segue.destinationViewController as! VerifyRegistrationViewController
            nextVC.user = self.user
        }
    }

    @IBAction func onTappedNextButton() {
        performSegueWithIdentifier("toVerify", sender: nil)
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

extension SetTagsViewController : UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
