//
//  String+Extension.swift
//  LEERandom
//
//  Created by 李江波 on 2017/9/17.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import Foundation

extension String {
    //Range转换为NSRange
   func nsRange(from range: Range<Index>) -> NSRange {
        let lower = UTF16View.Index(range.lowerBound, within: utf16)
        let upper = UTF16View.Index(range.upperBound, within: utf16)
        return NSRange(location: utf16.startIndex.distance(to: lower), length: lower.distance(to: upper))
    }

}
