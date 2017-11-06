//
//  ViewController.swift
//  LEERandom
//
//  Created by 李江波 on 2017/9/6.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

class ViewController: UIViewController {

    @IBOutlet weak var buttonTop: NSLayoutConstraint!
    @IBOutlet weak var button1Width: NSLayoutConstraint!
    @IBOutlet weak var button2Width: NSLayoutConstraint!
    @IBOutlet weak var homeBackGround: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        if #available(iOS 9.0, *) {
            let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
            attributeSet.title = "我来选"
            attributeSet.contentDescription = "快速产生随机的卡片~"
            attributeSet.keywords = ["抓阄", "随机选", "随便选", "随机", "公平选"]
            let item = CSSearchableItem(uniqueIdentifier: "keywprds", domainIdentifier: "keyW", attributeSet: attributeSet)
            CSSearchableIndex.default().indexSearchableItems([item], completionHandler: nil)
        } else {
            // Fallback on earlier versions
        }
        
        button1Width.constant = widthSize * 142;
        button2Width.constant = widthSize * 141;
        if ISIPHONE_X() {
            
            homeBackGround.image = #imageLiteral(resourceName: "home_X.png")
            buttonTop.constant = widthSize * 300;
        } else {
            homeBackGround.image = #imageLiteral(resourceName: "bg1")
            buttonTop.constant = widthSize * 231;
           
        }
        
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
}

