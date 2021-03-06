//
//  InputTextViewController.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/20.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//


import UIKit

// 1/2-1/3.任意の選択肢を元画面のtextfieldにinputするのに使う
protocol InputTextDelegate: class {
    func inputText(index index: Int, inputText: String)
}

class InputTextViewController: UIViewController {
    
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var inputTextView: UITextView!
    var selectedSection: Int!
    var sectionLabelText: String!
    var inputText: String!
    // 1/2-2/3. delegateの設定
    var inputTextDelegate: InputTextDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        if inputTextView.text != "" {
            // 1/2-3/3. 元画面にこの質問を選択肢を再登録
            self.inputTextDelegate?.inputText(index: selectedSection,
                                                      inputText: inputTextView.text)
        } else {
            print("未入力")
        }
    }
    
    func initView() {
        sectionLabel.text = sectionLabelText
        inputTextView.text = inputText
        inputTextView.delegate = self
        
        if selectedSection == 3 {
            inputTextView.keyboardType = .NumberPad
        } else if selectedSection == 5 {
            inputTextView.keyboardType = .NumberPad
        }
        
        
        inputTextView.becomeFirstResponder()
        
    }
}

extension InputTextViewController : UITextViewDelegate {
    
    //    func textViewDidChange(textView: UITextView) {
    //        textView.resolveHashTags()
    //    }
}
