//
//  TodayViewController.swift
//  LEERandomWidget
//
//  Created by ljb48229 on 2017/11/17.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    //设置展开和折叠
    @available(iOSApplicationExtension 10.0, *)
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        
    }
    
    @IBAction func ballAction(_ sender: UIButton) {
        
        let url = URL(string: "LEERandomWidget://qiuqiu")
        
        extensionContext?.open(url!, completionHandler: { (success) in
            
        })
    }
    
    @IBAction func cardAction(_ sender: UIButton) {
        let url = URL(string: "LEERandomWidget://card")
        
        extensionContext?.open(url!, completionHandler: { (success) in
            
        })
    }
    
    @IBAction func groupAction(_ sender: UIButton) {
        let url = URL(string: "LEERandomWidget://group")
        
        extensionContext?.open(url!, completionHandler: { (success) in
            
        })
    }
    
}
