//
//  SetInfomationOfHSViewController.swift
//  Matchy
//
//  Created by 井上航 on 2016/09/25.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class SetInfomationOfHSViewController: UIViewController {
    
    @IBOutlet weak var schoolNameTextField: UITextField!
    @IBOutlet weak var schoolGradeTextField: UITextField!
    @IBOutlet weak var interestTextField: UITextField!
    @IBOutlet weak var courseTextField: UITextField!
    @IBOutlet weak var clubTextField: UITextField!
    
    let schoolName = []
    let schoolGradeArray = ["中学1年生","中学2年生","中学3年生","高校1年生","高校2年生","高校3年生","その他(入力)"]
    let interestArray = ["自然科学・数学・法則","文学・国語・歴史","コンピュータ・プログラミング","デザイン・建築・都市","政治・社会・報道","生活・スポーツ・健康・美容","機械・工学・宇宙","コミュニティ・SNS・地域","音楽・芸術・文科","金融・経済・ビジネス","教育・子育て・介護","国際・海外支援・開発援助"]
    let courseArray = ["中学卒業後 就職","高校卒業後 就職","高校卒業後 専門学校に進学","高校卒業後 私立大学に進学","高校卒業後 国公立大学に進学","その他(入力)"]
    let clueArray = ["所属していない","陸上部","サッカー部","野球部","軟式野球部","バスケ部","バレー部","テニス部","水泳部","ハンドボール部","ラグビー部","アメフト部","卓球部","ソフトテニス部","バドミントン部","ソフトボール部","剣道部","柔道部","弓道部","空手部","ダンス部","バレエ部","体操部","新体操部","チアリーディング部","応援団","水球部","ｼﾝｸﾛﾅｲｽﾞﾄﾞｽｲﾐﾝｸﾞ部","吹奏楽部","軽音楽部","合唱部","茶道部","書道部","美術部","料理部","英語部","写真部","演劇部","その他(入力)"]
    
    var selectedTextFieldTag: Int!
    var inputTextArray = ["","","","",""]
    
    let user = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        print(inputTextArray)
        initUIParts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toSelect" {
            let nextVC = segue.destinationViewController as! SelectionTableViewController
            // 2/2-1/2. インスタンス化するタイミングでdelegateをset
            nextVC.inputSelectedSelectionDelegate = self
            nextVC.selectedArrayNumber = self.selectedTextFieldTag
            nextVC.inputTextArray = self.inputTextArray
            
            switch selectedTextFieldTag {
            case 0:
                print("error: selectedTextFieldTag = 0 ありえない")
            case 1:
                nextVC.displayArray = schoolGradeArray
            case 2:
                nextVC.displayArray = interestArray
            case 3:
                nextVC.displayArray = courseArray
            case 4:
                nextVC.displayArray = clueArray
            default:
                print("error: ありえない")
                
            }
        }
        else if segue.identifier == "toMyPage" {
            let nextVC = segue.destinationViewController as! SetMyPageViewController
            nextVC.user = self.user
        }
    }
    
    @IBAction func onTappedSchoolButton(sender: UIButton) {
        selectedTextFieldTag = 1
        performSegueWithIdentifier("toSelect", sender: nil)
    }
    @IBAction func onTappedInterestButton(sender: UIButton) {
        selectedTextFieldTag = 2
        performSegueWithIdentifier("toSelect", sender: nil)
    }
    @IBAction func onTappedCourseButton(sender: UIButton) {
        selectedTextFieldTag = 3
        performSegueWithIdentifier("toSelect", sender: nil)
    }
    @IBAction func onTappedClubButton(sender: UIButton) {
        selectedTextFieldTag = 4
        performSegueWithIdentifier("toSelect", sender: nil)
    }
    
    @IBAction func onTappedNextButton(sender: UIButton) {
        
        print("未入力項目があると次に進めません")
        guard let inputSchoolName     = schoolNameTextField.text else { return }
        guard let inputSchoolGrade    = schoolGradeTextField.text else { return }
        guard let inputSchoolInterest = interestTextField.text else { return }
        guard let inputSchoolCourse   = courseTextField.text else { return }
        guard let inputSchoolClub     = clubTextField.text else { return }
        print("すべての項目で入力が確認されました")
        
        let ud = NSUserDefaults.standardUserDefaults()
        user.uid = ud.objectForKey("uid") as! String
        
        user.schoolType = "HS"
        user.schoolName = inputSchoolName
        user.schoolGrade = inputSchoolGrade
        user.schoolInterest = inputSchoolInterest
        user.schoolClub = inputSchoolClub
        
        performSegueWithIdentifier("toMyPage", sender: nil)
    }
    
    func initUIParts() {
        schoolNameTextField.delegate = self
        schoolNameTextField.tag = 1
        schoolNameTextField.returnKeyType = .Done
        schoolNameTextField.attributedPlaceholder = NSAttributedString(
            string:"学校名（例：〇〇県立〇〇高校）",
            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        schoolNameTextField.text = inputTextArray[0]
        schoolNameTextField.enabled = true
        
        schoolGradeTextField.delegate = self
        schoolGradeTextField.tag = 2
        schoolGradeTextField.returnKeyType = .Done
        schoolGradeTextField.attributedPlaceholder = NSAttributedString(
            string:"学年",
            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        schoolGradeTextField.text = inputTextArray[1]
        schoolGradeTextField.enabled = false
        
        interestTextField.delegate = self
        interestTextField.tag = 3
        interestTextField.returnKeyType = .Done
        interestTextField.attributedPlaceholder = NSAttributedString(
            string:"興味のある分野",
            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        interestTextField.text = inputTextArray[2]
        interestTextField.enabled = false
        
        courseTextField.delegate = self
        courseTextField.tag = 4
        courseTextField.returnKeyType = .Done
        courseTextField.attributedPlaceholder = NSAttributedString(
            string:"進学希望",
            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        courseTextField.text = inputTextArray[3]
        courseTextField.enabled = false
        
        clubTextField.delegate = self
        clubTextField.tag = 5
        clubTextField.returnKeyType = .Done
        clubTextField.attributedPlaceholder = NSAttributedString(
            string:"部活動",
            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        clubTextField.text = inputTextArray[4]
        clubTextField.enabled = false
    }
    
}

// 2/2-2/2.任意のquestionをtableviewから削除するのに使う
extension SetInfomationOfHSViewController: InputSelectedSelectionDelegate {
    func inputSelectedSelection(index index: Int, inputText: String) {
        inputTextArray[index] = inputText
    }
}

extension SetInfomationOfHSViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.tag == 1 {
            if let text = textField.text {
                inputTextArray[0] = text
            } else {
                inputTextArray[0] = ""
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
