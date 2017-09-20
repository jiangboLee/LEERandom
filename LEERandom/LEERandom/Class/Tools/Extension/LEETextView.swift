//
//  LEETextView.swift
//  LEERandom
//
//  Created by 李江波 on 2017/9/20.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import UIKit

class LEETextView: UITextView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func caretRect(for position: UITextPosition) -> CGRect {
        var originalRext = super.caretRect(for: position)
        originalRext.size.height = 18
        return originalRext
    }
}
