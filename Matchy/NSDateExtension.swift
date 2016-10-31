//
//  NSDateExtension.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/16.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import Foundation
import UIKit

extension NSDate {
    
    // 現在時刻をformat: 2014/06/24 11:14:17として取得 ex: NSDate().getNowDateString
    var getNowDateString: String {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") // ロケールの設定
        dateFormatter.timeStyle = .MediumStyle
        dateFormatter.dateStyle = .MediumStyle
        return dateFormatter.stringFromDate(self) // -> 2014/06/24 11:14:17
    }
    
}
