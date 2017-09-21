//
//  UIColor+Extension.swift
//  LEERandom
//
//  Created by 李江波 on 2017/9/21.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import UIKit

extension UIColor {
    
    public func colorWithHex(hex: Int, alpha: CGFloat = 1) -> UIColor {
        
        let r = CGFloat((hex & 0xff0000) >> 16) / 255
        let g = CGFloat((hex & 0xff00) >> 8) / 255
        let b = CGFloat(hex & 0xff) / 255
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
}

