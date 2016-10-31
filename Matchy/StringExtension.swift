//
//  StringExtension.swift
//  Matchy
//
//  Created by 井上航 on 2016/10/16.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    // 半角、全角スペースを除いた文字列をreturn
    var removeAnySpace : String {
        
        var text: String!
        
        text = self.stringByReplacingOccurrencesOfString(" ", withString: "")
        text = text.stringByReplacingOccurrencesOfString("　", withString: "")
        
        return text
    }
    
    // SHA-1 Hash化
    var getSha1: String {
        
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_SHA1_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        
        CC_SHA1(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.destroy()
        
        return String(hash)
    }
    
    // 文字列を半角スペースで区切って配列にして返す
    var makeArrayBySpace: [String] {
        let array0 = self.componentsSeparatedByString(" ")
        var array1 = [String]()
        for item in array0 {
            if item != "" {
                array1.append(item)
            }
        }
        return array1
    }
    
}
