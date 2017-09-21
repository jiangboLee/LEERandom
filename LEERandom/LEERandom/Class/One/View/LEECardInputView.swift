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
    
    var addCard: Bool? {
        didSet {
            if addCard! {
                cardSureAction.isHidden = false
                lookCardDelButton.isHidden = true
                lookCardSureButton.isHidden = true
                cardTextView.becomeFirstResponder()
            } else {
                cardSureAction.isHidden = true
                lookCardDelButton.isHidden = false
                lookCardSureButton.isHidden = false
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
            
            }
        }
    }
    
    override func awakeFromNib() {
        
        
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        removeFromSuperview()
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
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 25
        let attributes = [NSParagraphStyleAttributeName: paragraphStyle]
        cardTextView.attributedText = NSAttributedString(string: textView.text, attributes: attributes)
        
        if (textView.text as NSString).length > 0 {
            noTextLable.isHidden = true
        } else {
            noTextLable.isHidden = false
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let selectedRange = textView.markedTextRange
        //获取高亮部分
        let pos = textView.position(from: (selectedRange?.start) ?? UITextPosition(), offset: 0)
        if (selectedRange != nil) && (pos != nil) {
            
            let startOffset = textView.offset(from: textView.beginningOfDocument, to: selectedRange!.start)
            let endOffset = textView.offset(from: textView.beginningOfDocument, to: selectedRange!.end)
            let offsetRange = NSMakeRange(startOffset, endOffset)
            
            if offsetRange.location < 40 {
                return true
            } else {
                return false
            }
        }
        let nsString = textView.text as NSString
        let comcatstr = nsString.replacingCharacters(in: range, with: text)
        let canInputlen = 40 - (comcatstr as NSString).length
        if canInputlen >= 0 {
            return true
        } else {
            let len = (text as NSString).length + canInputlen
            let rg = NSMakeRange(0, max(len, 0))
            if rg.length > 0 {
                let s = (text as NSString).substring(with: rg)
                textView.text = nsString.replacingCharacters(in: range, with: s)
                
            }
            return false
        }
    
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


