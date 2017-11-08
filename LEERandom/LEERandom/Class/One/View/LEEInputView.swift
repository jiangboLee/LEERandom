//
//  LEEInputView.swift
//  LEERandom
//
//  Created by 李江波 on 2017/9/17.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import UIKit

typealias funcSureInputBlock = (String) -> ()

class LEEInputView: UIView {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var inputViewTop: NSLayoutConstraint!
    @IBOutlet weak var sureInputButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    
    var sureInputBlock: funcSureInputBlock?
    
    @IBAction func closeInputViewAction(_ sender: Any) {
        inputTextField.resignFirstResponder()
        self.removeFromSuperview()
    }
    
    @IBAction func sureInputAction(_ sender: HighlightButton) {
        if (inputTextField.text! as NSString).length == 0 {
            return;
        }
        inputTextField.resignFirstResponder()
        self.sureInputBlock?(inputTextField.text!)
        self.removeFromSuperview()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sureInputButton.isSelected = true
        sureInputButton.isUserInteractionEnabled = false
        inputViewTop.constant = widthSize * 133;
        sureInputButton.isSelected = true
        inputTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        inputTextField.becomeFirstResponder()
    }
    
    @objc private func textFieldDidChange(textField: UITextField) {
        if ((textField.text! as NSString).length) > 0 {
            
            sureInputButton.isSelected = false
            sureInputButton.isUserInteractionEnabled = true
        } else {
            sureInputButton.isSelected = true
            sureInputButton.isUserInteractionEnabled = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
}

extension LEEInputView: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let str = textField.text! as NSString
        if string == "0" && str.length == 0 {
            return false
        }
        if str.length >= 4 {
            return false
        }
        return true
    }
}





