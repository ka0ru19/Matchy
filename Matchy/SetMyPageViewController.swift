//
//  SetMyPageViewController.swift
//  Matchy
//
//  Created by 井上航 on 2016/09/25.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit
import Firebase

class SetMyPageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var introductionTextView: UITextView!
    
    
    
    var inputTextArray = ["","",""]
    
    var user: UserModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUIParts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTappedImageButton() {
        
        let alert: UIAlertController = UIAlertController(title: "プロフィール写真", message: "写真は必須です", preferredStyle:  UIAlertControllerStyle.Alert)
        
        let cameraAction: UIAlertAction = UIAlertAction(title: "カメラ", style: UIAlertActionStyle.Default, handler:{(action: UIAlertAction!) -> Void in
            self.precentPickerController(.Camera)
        })
        let photoLibraryAction: UIAlertAction = UIAlertAction(title: "フォトライブラリ", style: UIAlertActionStyle.Default, handler:{(action: UIAlertAction!) -> Void in
            self.precentPickerController(.PhotoLibrary)
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.Cancel, handler:{(action: UIAlertAction!) -> Void in
            print("cancelAction")
        })
        alert.addAction(cameraAction)
        alert.addAction(photoLibraryAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    @IBAction func onTappedTextViewButton() {
        performSegueWithIdentifier("EditIntroduction", sender: nil)
    }
    @IBAction func onTappedNextButton() {
        
        guard let inputImage = imageView.image else { return }
        guard let inputId = idTextField.text else { return }
        guard let inputName = nameTextField.text else { return }
        guard let inputIntroduction = introductionTextView.text else { return }
        
        user.icon = inputImage
        user.id = inputId
        user.name = inputName
        user.intro = inputIntroduction
        
        performSegueWithIdentifier("toNext", sender: nil)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toNext" {
            let nextVC = segue.destinationViewController as! SetTagsViewController
            nextVC.user = self.user
        }
    }
    
    
    func initUIParts() {
        
        imageView.layer.cornerRadius = imageView.bounds.height / 2
        imageView.layer.borderColor = UIColor.whiteColor().CGColor
        
        idTextField.delegate = self
        idTextField.tag = 1
        idTextField.returnKeyType = .Done
        idTextField.attributedPlaceholder = NSAttributedString(
            string:"ユーザーネーム（半角16文字以内）",
            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        idTextField.text = inputTextArray[0]
        idTextField.enabled = true
        
        nameTextField.delegate = self
        nameTextField.tag = 2
        nameTextField.returnKeyType = .Done
        nameTextField.attributedPlaceholder = NSAttributedString(
            string:"自分を表す一言（18文字以内）",
            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        nameTextField.text = inputTextArray[1]
        nameTextField.enabled = true
        
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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.dismissViewControllerAnimated(true, completion: nil)
        // 画像を出力
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
}

extension SetMyPageViewController: UITextFieldDelegate , UITextViewDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
