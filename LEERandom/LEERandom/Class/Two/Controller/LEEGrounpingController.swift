//
//  LEEGrounpingController.swift
//  LEERandom
//
//  Created by 李江波 on 2017/11/2.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import UIKit

class LEEGrounpingController: UIViewController {

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var alertLable: UILabel!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func gobackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func beiginGroupingAction(_ sender: Any) {
        
        guard let num = textField1.text else {
            return
        }
        guard let zhuNum = textField2.text else {
            return
        }
        
        if (num as NSString).length == 0 {
            animationAlertLable(swith: 1)
            return
        }
        if (zhuNum as NSString).length == 0 {
            animationAlertLable(swith: 2)
            return
        }
        
        if (num as NSString).intValue > 9999 {
            animationAlertLable(swith: 3)
            return
        }
        if (num as NSString).intValue < (zhuNum as NSString).intValue {
            animationAlertLable(swith: 4)
            return
        }
        
        var arr:[Int] = []
        for i in 1...(num as NSString).intValue {
            arr.append(Int(i))
        }
        
        arr = shuffle(arr: arr)
        print(arr)
        
    }
    //MARK: 数组随机排列
    private func shuffle(arr: Array<Int>) -> Array<Int> {
        var arr = arr
        for index in 0..<arr.count {
            let newIndex = Int(arc4random_uniform(UInt32(arr.count - index))) + index
            if index != newIndex {
                arr.swapAt(index, newIndex)
            }
        }
        return arr
    }
    
    private func animationAlertLable(swith: Int) {
        
        switch swith {
        case 1:
            alertLable.text = "请输入数字哦"
        case 2:
            alertLable.text = "请输入组数哦"
        case 3:
            alertLable.text = "输入数字不能大于9999哦"
        case 4:
            alertLable.text = "组数不能大于总数哦"
        default:
            alertLable.text = "请输入数字哦"
        }
        alertLable.isHidden = false
        alertLable.alpha = 0.5
        UIView.animate(withDuration: 1) {
            self.alertLable.alpha = 1
        }
        UIView.animate(withDuration: 1, animations: {
           self.alertLable.alpha = 0;
        }) { (_) in
            self.alertLable.isHidden = true
        }
        
    }
    
}
