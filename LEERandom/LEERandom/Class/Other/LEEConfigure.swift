//
//  LEEConfigure.swift
//  LEERandom
//
//  Created by 李江波 on 2017/9/11.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import UIKit

public let widthSize: CGFloat = UIScreen.main.bounds.width / 375
public func ISIPHONE_SE() -> Bool {
    return UIScreen.main.bounds.width == CGFloat(320.0)
}
public func ISIPHONE_X() -> Bool {
    return UIScreen.main.bounds.height == CGFloat(812.0)
}



public let screenWidth = UIScreen.main.bounds.width
public let screenHeight = UIScreen.main.bounds.height
