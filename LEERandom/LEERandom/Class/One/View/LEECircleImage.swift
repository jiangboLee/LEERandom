//
//  LEECircleImage.swift
//  LEERandom
//
//  Created by 李江波 on 2017/9/10.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import UIKit

class LEECircleImage: UIImageView {

    @available(iOS 9.0, *)
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        get {
            return .ellipse
        }
    }
}
