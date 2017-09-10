//
//  LEELotController.swift
//  LEERandom
//
//  Created by 李江波 on 2017/9/9.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import UIKit

class LEELotController: ViewController {

    @IBOutlet weak var switchButton1: UIButton!
    
    @IBOutlet weak var switchButton2: UIButton!
    
    @IBOutlet weak var switchBackgroundImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switchButton1.isUserInteractionEnabled = false
        switchButton2.isSelected = true
        switchButton2.isUserInteractionEnabled = true
        
        
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    //MARK: 点击事件
    
    @IBAction func popAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func switchButtonAction(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        sender.isSelected = false
        switchButton2.isSelected = true
        self.switchButton2.isUserInteractionEnabled = true
        
        UIView.animate(withDuration: 0.05, animations: {
            
            self.switchBackgroundImage.transform = CGAffineTransform.identity
        }) { (finish) in
            
        }
        
    }
    
    @IBAction func switchButton2Action(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        sender.isSelected = false
        switchButton1.isSelected = true
        switchButton1.isUserInteractionEnabled = true
        
        UIView.animate(withDuration: 0.05, animations: {
            
            self.switchBackgroundImage.transform = CGAffineTransform.init(translationX: 75, y: 0)
        }) { (finish) in
            
        }
    }

    
    
    @IBAction func removeSameAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected;
        if sender.isSelected {
            sender.setImage(#imageLiteral(resourceName: "quchong-selected"), for: [.highlighted, .selected])
            
        } else {
            sender.setImage(#imageLiteral(resourceName: "quchong"), for: UIControlState.highlighted )
        }
    }
}
