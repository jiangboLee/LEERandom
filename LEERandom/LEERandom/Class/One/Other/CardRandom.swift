//
//  CardRandom.swift
//  LEERandom
//
//  Created by 李江波 on 2017/9/23.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import UIKit

class CardRandom: NSObject {
    
    //单例
    static let shared = CardRandom.init()
    private override init() {}
    
    var numArr:[Int] = []
    var num: Int? {
        didSet {
            numArr.removeAll()
            for a in 1...num! {
                numArr.append(a)
            }
        }
    }
    
    
    func cardStart() -> Int {
        if numArr.count == 0 {
            return 0
        }
        let b = Int(arc4random()) % numArr.count
        let a = numArr[b]
        numArr.remove(at: b)
        return a
    }
    
    func cardNoAgainStart() -> Int {
        let b = arc4random_uniform(UInt32(numArr.count))
        return numArr[Int(b)]
    }
}

