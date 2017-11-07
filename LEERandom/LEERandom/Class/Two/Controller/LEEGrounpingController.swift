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
    @IBOutlet weak var bgImageV: UIImageView!
    
    @IBOutlet weak var topXconstraint: NSLayoutConstraint!
    
    @IBOutlet weak var goBackButtonTop: NSLayoutConstraint!
    
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

        if ISIPHONE_X() {
            
            bgImageV.image = #imageLiteral(resourceName: "gorupX.png")
            topXconstraint.constant = 210 + 50;
            goBackButtonTop.constant = 34 + 43;
        } else {
            bgImageV.image = #imageLiteral(resourceName: "fenzu_bg")
            topXconstraint.constant = 210;
            goBackButtonTop.constant = 34;
        }
        
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
        
        let zoomNum = (num as NSString).integerValue
        let gropNum = (zhuNum as NSString).integerValue
        
        
        if zoomNum > 9999 {
            animationAlertLable(swith: 3)
            return
        }
        if zoomNum < gropNum {
            animationAlertLable(swith: 4)
            return
        }
        
        var arr:[String] = []
        for i in 1...(num as NSString).intValue {
            arr.append("\(i)")
        }
        
        if zoomNum % gropNum == 0 {
            
        } else {
            
        }
        
        arr = shuffle(arr: arr) as! [String]
//        print(arr)
        
        let alertView = UINib.init(nibName: "LEEStareAlertView", bundle: nil).instantiate(withOwner: nil, options: nil).last as! LEEStareAlertView
        alertView.frame = UIScreen.main.bounds
        view.addSubview(alertView)
        
        alertView.zhuNum = gropNum
        alertView.resultArr = splitArray(arr: arr, subSize: gropNum)
        
        
    }
    //MARK:  将数组拆分成固定长度
    private func splitArray(arr: Array<String>, subSize: Int) -> Array<String> {
        
        let count = arr.count / subSize
        var mutableArr: [String] = []
        
        for i in 0..<subSize {
           
            let index = i * count
            var tempArr:[String] = []
            tempArr.removeAll()
            var j = index
            while (j < count * (i + 1) && j < arr.count) {
                
                tempArr.append(arr[j])
                j += 1
            }
            if i == subSize - 1 {
                while (j >=  count * (i + 1) && j < arr.count) {
                    
                    tempArr.append(arr[j])
                    j += 1
                }
            }
            let string = tempArr.joined(separator: ",")
            mutableArr.append(string)
            
        }
        return mutableArr
    }
    
    //MARK: 数组随机排列
    private func shuffle(arr: Array<Any>) -> Array<Any> {
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
