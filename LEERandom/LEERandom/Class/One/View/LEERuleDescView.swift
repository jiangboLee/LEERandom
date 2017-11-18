//
//  LEERuleDescView.swift
//  LEERandom
//
//  Created by 李江波 on 2017/11/18.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import UIKit

class LEERuleDescView: UIView {

    @IBOutlet weak var ruleImageV: UIImageView!
    
    @IBOutlet weak var closeButton: HighlightButton!
    
    enum RuleType {
        case RuleTypeBall
        case RuleTypeCard
        case RuleTypeGroup
    }
    
    public var type: RuleType? {
        didSet {
            switch type {
            case .RuleTypeBall?:
                ruleImageV.image = #imageLiteral(resourceName: "chouqiuqiu-guize")
                closeButton.setImage(#imageLiteral(resourceName: "close"), for: .normal)
                closeButton.setImage(#imageLiteral(resourceName: "close"), for: .highlighted)
                break
            case .RuleTypeCard?:
                ruleImageV.image = #imageLiteral(resourceName: "fankapian-guize")
                closeButton.setImage(#imageLiteral(resourceName: "close"), for: .normal)
                closeButton.setImage(#imageLiteral(resourceName: "close"), for: .highlighted)
                break
            case .RuleTypeGroup?:
                ruleImageV.image = #imageLiteral(resourceName: "fenzu-guize")
                closeButton.setImage(#imageLiteral(resourceName: "tanchuang_close"), for: .normal)
                closeButton.setImage(#imageLiteral(resourceName: "tanchuang_close"), for: .highlighted)
                break
            case .none:
                ruleImageV.image = #imageLiteral(resourceName: "chouqiuqiu-guize")
                closeButton.setImage(#imageLiteral(resourceName: "close"), for: .normal)
                closeButton.setImage(#imageLiteral(resourceName: "close"), for: .highlighted)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromSuperview()
    }
    
    @IBAction func closeAction(_ sender: Any) {
        
        self.removeFromSuperview()
    }
    

}
