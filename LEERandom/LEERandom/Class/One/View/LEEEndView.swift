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
    
    @IBOutlet weak var numLable: UILabel!
    
    
    var againBlock: funcAgainBlock?
    var goonBlock: funcGoonBlock?
    var removeSame: Bool = false {
        didSet {
            leaveBallsLable.isHidden = removeSame
        }
    }
    private var chooseNum: Int?
    
    var levelBalls: Int? {
        didSet {
            let str = "*我来选提醒您还剩 \(levelBalls!) 个球"
            let attr = NSMutableAttributedString(string: str)
            let range = str.range(of: "\(levelBalls!)")!
            attr.addAttributes([NSForegroundColorAttributeName: UIColor.yellow], range: str.nsRange(from: range))
            leaveBallsLable.attributedText = attr
        }
    }
    
    
    
    var ballNum: Int? {
        didSet {
            
//            if removeSame {
//               chooseNum = produce.noAgainStart()
//            } else {
////               chooseNum = produce.start()
//            }
            numLable.text = String(describing: ballNum!)
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
