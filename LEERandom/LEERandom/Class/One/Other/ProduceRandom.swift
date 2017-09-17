//
//  produceRandom.swift
//  randaaaaaaaa
//
//  Created by ljb48229 on 2017/9/15.
//  Copyright © 2017年 ljb48229. All rights reserved.
//

import UIKit

class ProduceRandom: NSObject {
    
    //单例
    static let shared = ProduceRandom.init()
    private override init() {}
    
    var numArr:[Int] = []
    var num: Int? {
        didSet {
            for a in 1...num! {
                numArr.append(a)
            }
        }
    }
    
    
    func start() -> Int {
        if numArr.count == 0 {
            return 0
        }
        let b = Int(arc4random()) % numArr.count
        let a = numArr[b]
        numArr.remove(at: b)
        return a
    }
    
    func noAgainStart() -> Int {
        let b = arc4random_uniform(UInt32(numArr.count))
        return numArr[Int(b)]
    }
}










