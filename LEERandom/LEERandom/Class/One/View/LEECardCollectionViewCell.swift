//
//  LEECardCollectionViewCell.swift
//  LEERandom
//
//  Created by 李江波 on 2017/9/21.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import UIKit

class LEECardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardBg: UIImageView!
    
    @IBOutlet weak var cardNumLable: UILabel!
    
    var needAnimation: Bool = true
    
    var index: NSInteger = 0 {
        didSet {
            switch index {
            case 1:
                cardBg.image = #imageLiteral(resourceName: "add-1")
                cardNumLable.isHidden = true
                break
            case 2:
                cardBg.image = #imageLiteral(resourceName: "zhipai")
                cardNumLable.isHidden = false
                cardNumLable.textColor = UIColor().colorWithHex(hex: 0xF1C755)
                
                break
            case 3:
                cardBg.image = #imageLiteral(resourceName: "fanchu")
                cardNumLable.isHidden = false
                cardNumLable.textColor = UIColor().colorWithHex(hex: 0xFEFAF0)
                break
            case 4:
                cardBg.image = #imageLiteral(resourceName: "wenhao")
                cardNumLable.isHidden = true
                
                if needAnimation {
                    
                    self.layer.removeAllAnimations()
                    self.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1)
                    UIView.animate(withDuration: 0.5, animations: {
                        
                        self.layer.transform = CATransform3DMakeScale(1, 1, 1)
                    }, completion: { (finished) in
                        
                        let transition = CATransition()
                        transition.type = "rippleEffect"
                        transition.duration = 0.5
                        //                    transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                        transition.subtype = kCATransitionFade
                        self.layer.add(transition, forKey: nil)
                        
                    })
                }
                
                
                break
            default:
                break
            }
        }
    }
    
    var cardNum: NSInteger = 0 {
        didSet {
            cardNumLable.text = "\(cardNum)"
        }
    }
    
}
