//
//  LEECardInputView.swift
//  LEERandom
//
//  Created by 李江波 on 2017/9/20.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import UIKit

typealias CardSureBlock = (String) -> ()
typealias CardDeletedBlock = () -> ()

class LEECardInputView: UIView {

    @IBOutlet weak var cardTextView: UITextView!
    @IBOutlet weak var noTextLable: UILabel!
    
    @IBOutlet weak var cardTitle: UILabel!
    @IBOutlet weak var cardSureAction: UIButton!
    @IBOutlet weak var lookCardDelButton: HighlightButton!
    
    @IBOutlet weak var lookCardSureButton: HighlightButton!
    
    var cardSureBlock: CardSureBlock?
    var cardDeletedBlock: CardDeletedBlock?
    
    var addCard: NSInteger = 0 {
        didSet {
            switch addCard {
                case 1:
                    cardSureAction.isHidden = false
                    lookCardDelButton.isHidden = true
                    lookCardSureButton.isHidden = true
                    cardTextView.becomeFirstResponder()
                    break
                case 2:
                    cardSureAction.isHidden = true
                    lookCardDelButton.isHidden = false
                    lookCardDelButton.isSelected = false
                    lookCardSureButton.isSelected = false
                    lookCardSureButton.isHidden = false
                    break
                case 3:
                    cardSureAction.isHidden = true
                    lookCardDelButton.isHidden = false
                    lookCardDelButton.isSelected = true
                    lookCardSureButton.isHidden = false
                    lookCardSureButton.isSelected = true
                    cardTextView.isUserInteractionEnabled = false
                    break
                default:
                    break
            }
        }
    }
    var cardStr: String = "" {
        didSet {
            if (cardStr as NSString).length > 0 {
                noTextLable.isHidden = true
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 25
                let attributes = [NSParagraphStyleAttributeName: paragraphStyle]
                cardTextView.attributedText = NSAttributedString(string: cardStr, attributes: attributes)
            } else {
                noTextLable.isHidden = false
                noTextLable.text = "未设置内容"
            }
        }
    }
    
    override func awakeFromNib() {
        //修改行间距
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 25
        let attributes = [NSParagraphStyleAttributeName: paragraphStyle]
        cardTextView.typingAttributes = attributes
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        removeFromSuperview()
       if lookCardSureButton.isHidden == false
        && lookCardSureButton.isSelected == true {
        
            self.cardSureBlock?(cardTextView.text)
        }
    }
    
    @IBAction func cardSureAction(_ sender: UIButton) {
        
        removeFromSuperview();
        self.cardSureBlock?(cardTextView.text)
    }
    
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }

}

extension LEECardInputView: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = 25
//        let attributes = [NSParagraphStyleAttributeName: paragraphStyle]
//        cardTextView.attributedText = NSAttributedString(string: textView.text, attributes: attributes)
        
        if (textView.text as NSString).length > 0 {
            noTextLable.isHidden = true
        } else {
            noTextLable.isHidden = false
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text as NSString
        let updatedText = currentText.replacingCharacters(in: range, with: text)
       
        return updatedText.characters.count <= 40
        
        
        
//        let selectedRange = textView.markedTextRange
//        //获取高亮部分
//        let pos = textView.position(from: (selectedRange?.start) ?? UITextPosition(), offset: 0)
//        if (selectedRange != nil) && (pos != nil) {
//            
//            let startOffset = textView.offset(from: textView.beginningOfDocument, to: selectedRange!.start)
//            let endOffset = textView.offset(from: textView.beginningOfDocument, to: selectedRange!.end)
//            let offsetRange = NSMakeRange(startOffset, endOffset - startOffset)
//            
//            if offsetRange.location < 40 {
//                return true
//            } else {
//                return false
//            }
//        }
//        let nsString = textView.text as NSString
//        let comcatstr = nsString.replacingCharacters(in: range, with: text)
//        let canInputlen = 40 - (comcatstr as NSString).length
//        if canInputlen >= 0 {
//            return true
//        } else {
//            let len = (text as NSString).length + canInputlen
//            let rg = NSMakeRange(0, max(len, 0))
//            if rg.length > 0 {
//                let s = (text as NSString).substring(with: rg)
//                textView.text = nsString.replacingCharacters(in: range, with: s)
//                
//            }
//            return false
//        }
    
    }
    
    //MARK: 删除
    @IBAction func closeButton2Action(_ sender: Any) {
        
        removeFromSuperview()
        self.cardDeletedBlock?()
    }
    
    //MARK: 完成
    @IBAction func sureButton2Action(_ sender: Any) {
        removeFromSuperview()
        self.cardSureBlock?(cardTextView.text)
    }
}


