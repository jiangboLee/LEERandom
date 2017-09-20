//
//  LEEFlowLayout.swift
//  LEERandom
//
//  Created by 李江波 on 2017/9/20.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import UIKit

class LEEFlowLayout: UICollectionViewFlowLayout {

    override func prepare() {
        super.prepare()
        
        itemSize = CGSize(width: 91 * widthSize, height: 130 * widthSize)
        scrollDirection = .vertical
        minimumLineSpacing = 22 * widthSize
        minimumInteritemSpacing = (screenWidth - 64 - 91 * 3 * widthSize) / 2  
    }
}
