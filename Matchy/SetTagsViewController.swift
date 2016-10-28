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
    
    @IBOutlet weak var tagLabel0: UILabel!
    @IBOutlet weak var tagLabel1: UILabel!
    @IBOutlet weak var tagLabel2: UILabel!
    @IBOutlet weak var tagLabel3: UILabel!
    @IBOutlet weak var tagLabel4: UILabel!
    @IBOutlet weak var tagLabel5: UILabel!
    
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    var labelArray = [UILabel]()
    var buttonArray = [UIButton]()
    
    var showTagsArray = ["","","","","",""] // ex: "#タグ1 #tag2 #タグ3 "
    
    var selectedTagTextFieldNumber: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        showTags()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toVerify" {
            let nextVC = segue.destinationViewController as! VerifyRegistrationViewController
            nextVC.user = self.user
        }else if segue.identifier == "toInputTag" {
            let nextVC = segue.destinationViewController as! InputTagViewController
            nextVC.inputTagDelegate = self
            nextVC.selectedSection = self.selectedTagTextFieldNumber // 0~5
            nextVC.inputText = showTagsArray[selectedTagTextFieldNumber]
        }
    }
    
    @IBAction func onTappedNextButton() {
        for i in 0 ..< showTagsArray.count {
            user.tagArray += showTagsArray[i].makeArrayBySpace
            
        }
        performSegueWithIdentifier("toVerify", sender: nil)
    }
    
    func onTappedTagsButton(sender: UIButton) {
        selectedTagTextFieldNumber = sender.tag - 10
        performSegueWithIdentifier("toInputTag", sender: nil)
    }
    
    func showTags() {
        for i in 0 ..< labelArray.count {
            labelArray[i].text = showTagsArray[i]
        }
    }
    
    func initView() {
        
        labelArray.append(tagLabel0)
        labelArray.append(tagLabel1)
        labelArray.append(tagLabel2)
        labelArray.append(tagLabel3)
        labelArray.append(tagLabel4)
        labelArray.append(tagLabel5)
        
        buttonArray.append(button0)
        buttonArray.append(button1)
        buttonArray.append(button2)
        buttonArray.append(button3)
        buttonArray.append(button4)
        buttonArray.append(button5)
        
        for i in 0 ..< buttonArray.count {
            buttonArray[i].addTarget(self,
                                     action: #selector(SetTagsViewController.onTappedTagsButton(_:)),
                                     forControlEvents: .TouchUpInside)
            buttonArray[i].tag = 10 + i
        }
        
    }
    
}

// 2/2-2/2.tagをnextVCから編集するのに使う
extension SetTagsViewController: InputTagDelegate {
    func inputTag(index index: Int, inputTagText: String){
        showTagsArray[index] = inputTagText
    }
}

