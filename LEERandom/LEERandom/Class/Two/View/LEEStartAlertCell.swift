//
//  LEEStartAlertCell.swift
//  LEERandom
//
//  Created by 李江波 on 2017/11/4.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import UIKit

class LEEStartAlertCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var scroolV: UIScrollView!
    
    public var groupNum: Int? {
        didSet {
            title.text = "组\(String(describing: groupNum!)):"
        }
    }
    
    public var groupStr: String? {
        didSet {
            let str = groupStr! as NSString
            let tempRect = str.boundingRect(with: CGSize.init(width: 10000, height: 30), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont(name: "FZZhunYuan-M02S", size: 25)!], context: nil)
//            print(tempRect)
            lable.text = groupStr
            lable.LEE_Width = tempRect.width
            scroolV.contentSize = tempRect.size
        }
    }
    
    var lable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "FZZhunYuan-M02S", size: 25)
        lable.textColor = UIColor().colorWithHex(hex: 0x7c6bc9)
        lable.numberOfLines = 1
        
        return lable
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        scroolV.addSubview(lable)
        lable.snp.makeConstraints { (make) in
            make.leading.equalTo(scroolV)
            make.centerY.equalTo(scroolV)
//            make.width.equalTo(10000)
        }
    }
    
}
