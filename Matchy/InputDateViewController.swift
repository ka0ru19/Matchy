//
//  InputDateViewController.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/30.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

// 1/2-1/3.任意の選択肢を元画面のtextfieldにinputするのに使う
protocol InputDateDelegate: class {
    func inputText(index index: Int, inputText: String)
}

class InputDateViewController: UIViewController {

    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var selectedSection: Int!
    var sectionLabelText: String!
    var inputDateString: String!
    // 1/2-2/3. delegateの設定
    var inputDateDelegate: InputDateDelegate?
    
    let dateFormatter: NSDateFormatter = NSDateFormatter()
    let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
    let now = NSDate()
    
    let minHourInterval = 1      // 1分以上
    let maxHourInterval = 7 * 24 * 60 // 7日以内
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
            self.inputDateDelegate?.inputText(index: selectedSection, inputText: dateLabel.text!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        
//        sectionLabel.text = sectionLabelText
        dateLabel.text = inputDateString
        
        datePicker.timeZone = NSTimeZone.localTimeZone()
        datePicker.addTarget(self,
                             action: #selector(InputDateViewController.didChangeDate(_:)),
                             forControlEvents: .ValueChanged)
        
        dateFormatter.dateFormat = "yyyy/MM/dd hh:mm"
        
        let minDate = calendar.dateByAddingUnit(.Minute, value: minHourInterval, toDate: now, options: NSCalendarOptions())!
        let maxDate = calendar.dateByAddingUnit(.Minute, value: maxHourInterval, toDate: now, options: NSCalendarOptions())!
        
        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate
        
        datePicker.setDate(minDate, animated: true)
    }
    
    internal func didChangeDate(sender: UIDatePicker) {
        // フォーマットを生成.
        dateFormatter.dateFormat = "yyyy/MM/dd hh:mm"
        
        // 日付をフォーマットに則って取得.
        dateLabel.text = dateFormatter.stringFromDate(sender.date)
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
