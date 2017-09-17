//
//  UIView+Extension.swift
//  LEERandom
//
//  Created by 李江波 on 2017/9/10.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import UIKit

extension UIView {

    public var LEE_X: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }
    }
    public var LEE_Y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var r = self.frame
            r.origin.y = newValue
            self.frame = r
        }
    }
    public var LEE_Width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var r = self.frame
            r.size.width = newValue
            self.frame = r
        }
    }
    public var LEE_Height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var r = self.frame
            r.size.height = newValue
            self.frame = r
        }
    }
    public var LEE_CenterX: CGFloat {
        get {
            return self.center.x
        }
        set {
            var r = self.center
            r.x = newValue
            self.center = r
        }
    }
    public var LEE_CenterY: CGFloat {
        get {
            return self.center.y
        }
        set {
            var r = self.center
            r.y = newValue
            self.center = r
        }
    }
    @IBInspectable public var LEE_CornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
    
    /// 阴影
    @IBInspectable public var LEE_shadowColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue.cgColor
        }
    }
    @IBInspectable public var LEE_shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    @IBInspectable public var LEE_shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
            self.layer.shadowOpacity = 0.35
        }
    }
}
