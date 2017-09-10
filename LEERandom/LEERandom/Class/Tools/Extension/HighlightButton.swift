//
//  UIButton+Extension.swift
//  LEERandom
//
//  Created by 李江波 on 2017/9/10.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import UIKit

class HighlightButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                
                UIView.animate(withDuration: 0.1) {
                    self.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
                }
            } else {
                
                UIView.animate(withDuration: 0.1) {
                    self.transform = CGAffineTransform.identity
                }
            }
        }
    }
}
