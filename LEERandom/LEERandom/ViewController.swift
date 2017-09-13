//
//  ViewController.swift
//  LEERandom
//
//  Created by 李江波 on 2017/9/6.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonTop: NSLayoutConstraint!
    @IBOutlet weak var button1Width: NSLayoutConstraint!
    @IBOutlet weak var button2Width: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonTop.constant = widthSize * 231;
        button1Width.constant = widthSize * 142;
        button2Width.constant = widthSize * 141;
    }


}

