//
//  LEEEndView.swift
//  LEERandom
//
//  Created by 李江波 on 2017/9/14.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import UIKit

typealias funcAgainBlock = () -> ()
typealias funcGoonBlock = () -> ()

class LEEEndView: UIView {

    @IBOutlet weak var buttonsTop: NSLayoutConstraint!
    
    @IBOutlet weak var againButtonWidth: NSLayoutConstraint!
    
    @IBOutlet weak var goonButtonWidth: NSLayoutConstraint!
    
    @IBOutlet weak var congratulationsViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var leaveBallsLable: UILabel!
    
    
    var againBlock: funcAgainBlock?
    var goonBlock: funcGoonBlock?
    var ballNum: String? {
        didSet {
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        buttonsTop.constant = widthSize * 50
        againButtonWidth.constant = widthSize * 124
        goonButtonWidth.constant = widthSize * 124
        congratulationsViewWidth.constant = widthSize * 330
    }
    
    @IBAction func againPlayAction(_ sender: Any) {
        
        removeFromSuperview()
        self.againBlock?()
    }
    
    @IBAction func goonPlayAction(_ sender: Any) {
        
        removeFromSuperview()
        self.goonBlock?()
    }

}
