//
//  SetMyPageViewController.swift
//  Matchy
//
//  Created by 井上航 on 2016/09/25.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class SetMyPageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var introductionTextView: UITextView!
    
    var inputTextArray = ["","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTappedImageButton(sender: UIButton) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func initUIParts() {
        
        imageView.layer.cornerRadius = imageView.bounds.height / 2
        imageView.layer.borderColor = UIColor.whiteColor().CGColor
        
        nameTextField.delegate = self
        nameTextField.tag = 1
        nameTextField.returnKeyType = .Done
        nameTextField.attributedPlaceholder = NSAttributedString(
            string:"ユーザーネーム（半角16文字以内）",
            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        nameTextField.text = inputTextArray[0]
        nameTextField.enabled = true
        
        commentTextField.delegate = self
        commentTextField.tag = 2
        commentTextField.returnKeyType = .Done
        commentTextField.attributedPlaceholder = NSAttributedString(
            string:"自分を表す一言（18文字以内）",
            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        commentTextField.text = inputTextArray[1]
        commentTextField.enabled = false
        
        introductionTextView.delegate = self
        introductionTextView.tag = 3
        introductionTextView.returnKeyType = .Done
//        introductionTextView.attributedPlaceholder = NSAttributedString(
//            string:"興味のある分野",
//            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        introductionTextView.text = inputTextArray[2]
        introductionTextView.editable = false
        
        
        
    }


}

extension SetMyPageViewController: UITextFieldDelegate , UITextViewDelegate {
    
}
