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

        initUIParts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTappedImageButton() {
        
    }
    @IBAction func onTappedTextViewButton() {
        performSegueWithIdentifier("EditIntroduction", sender: nil)
    }
    @IBAction func onTappedNextButton() {
        performSegueWithIdentifier("toNext", sender: nil)
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
        commentTextField.enabled = true
        
        introductionTextView.delegate = self
        introductionTextView.tag = 3
        introductionTextView.returnKeyType = .Done
        introductionTextView.layer.borderColor = UIColor.blackColor().CGColor
        introductionTextView.layer.borderWidth = 1.0
        introductionTextView.text = inputTextArray[2]
        introductionTextView.editable = false
        
    }
}

extension SetMyPageViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    // カメラ、アルバムの呼び出しメソッド(カメラorアルバムのソースタイプが引き数)
    func precentPickerController(sourceType: UIImagePickerControllerSourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.presentViewController(picker, animated: true, completion: nil)
        }
    }
    
    // 写真が選択された時に呼び出されるメソッド
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        // 画像を出力
        imageView.image = image
    }
    

}

extension SetMyPageViewController: UITextFieldDelegate , UITextViewDelegate {
    
}
