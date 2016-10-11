//
//  HSQuestionInputViewController.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/11.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

// 1/2-1/3.任意の選択肢を元画面のtextfieldにinputするのに使う
protocol InputPostTextDelegate: class {
    func inputPostText(index index: Int, inputText: String)
}

class HSQuestionInputViewController: UIViewController {
    
    @IBOutlet weak var inputTextView: UITextView!
    var selectedSection: Int!
    var inputText: String!
    // 1/2-2/3. delegateの設定
    var inputPostTextDelegate: InputPostTextDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputTextView.text = inputText
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        if inputTextView.text != "" {
            // 1/2-3/3. 元画面にこの質問を選択肢を再登録
            self.inputPostTextDelegate?.inputPostText(index: selectedSection,
                                                      inputText: inputTextView.text)
        } else {
            print("未入力")
        }
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
