//
//  SelectionTableViewController.swift
//  Matchy
//
//  Created by 井上航 on 2016/09/25.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

// 1/2-1/3.任意の選択肢を元画面のtextfieldにinputするのに使う
protocol InputSelectedSelectionDelegate: class {
    func inputSelectedSelection(index index: Int, inputText: String)
}

class SelectionTableViewController: UITableViewController {
    
    var selectedArrayNumber: Int! // 基本的に1~4
    var displayArray = [String]()
    var selectedItemsIndexArray = [Int]()
    var multiSelectLimit: Int = 1
    
    var inputTextArray = [String]()
    
    // 1/2-2/3. delegateの設定
    var inputSelectedSelectionDelegate: InputSelectedSelectionDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return displayArray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        if inputTextArray[selectedArrayNumber] == displayArray[indexPath.row] {
            cell.textLabel?.text = displayArray[indexPath.row]
            cell.textLabel?.textColor = UIColor.blackColor()
            cell.contentView.backgroundColor = UIColor(red: 255/255, green: 254/255, blue: 219/255, alpha: 1.0)
            
        } else {
            cell.textLabel?.text = displayArray[indexPath.row]
            cell.textLabel?.textColor = UIColor.grayColor()
            cell.contentView.backgroundColor = UIColor.whiteColor()
        }
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("関数開始")
        print(selectedItemsIndexArray)
        
        guard let cell = tableView.cellForRowAtIndexPath(indexPath) else {
            print("error")
            return
        }
        
        //        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        for i in 0 ..< selectedItemsIndexArray.count {
            if selectedItemsIndexArray[i] == indexPath.row {
                cell.textLabel?.text = displayArray[indexPath.row]
                cell.textLabel?.textColor = UIColor.grayColor()
                cell.contentView.backgroundColor = UIColor.whiteColor()
                
                selectedItemsIndexArray.removeAtIndex(i)
                print("変更後")
                print(selectedItemsIndexArray)
                inputTextArray[selectedArrayNumber] = ""
                // 1/2-3/3. 元画面にこの質問を選択肢を再登録
                self.inputSelectedSelectionDelegate?.inputSelectedSelection(index: selectedArrayNumber,
                                                                            inputText: "")
                return
            }
        }
        
        if selectedItemsIndexArray.count >= multiSelectLimit {
            print("選択している数が\(multiSelectLimit)を超えました")
            let targetIndexPath = NSIndexPath(forRow: selectedItemsIndexArray[0], inSection: 0)
            guard let targetCell = tableView.cellForRowAtIndexPath(targetIndexPath) else {
                print("error")
                return
            }
            print(targetIndexPath.row)
            targetCell.textLabel?.text = displayArray[targetIndexPath.row]
            targetCell.textLabel?.textColor = UIColor.grayColor()
            targetCell.contentView.backgroundColor = UIColor.whiteColor()
            
            selectedItemsIndexArray.removeAtIndex(0)
        }
        
        
        cell.textLabel?.text = displayArray[indexPath.row]
        cell.textLabel?.textColor = UIColor.blackColor()
        cell.contentView.backgroundColor = UIColor(red: 255/255, green: 254/255, blue: 219/255, alpha: 1.0)
        
        selectedItemsIndexArray.append(indexPath.row)
        print("変更後")
        print(selectedItemsIndexArray)
        // 1/2-3/3. 元画面にこの質問を選択肢を再登録
        self.inputSelectedSelectionDelegate?.inputSelectedSelection(index: selectedArrayNumber,
                                                                    inputText: displayArray[selectedItemsIndexArray[0]])
        inputTextArray[selectedArrayNumber] = displayArray[selectedItemsIndexArray[0]]
        print(inputTextArray)
        
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
