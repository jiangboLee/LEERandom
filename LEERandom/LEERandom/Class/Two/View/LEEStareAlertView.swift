//
//  LEEStareAlertView.swift
//  LEERandom
//
//  Created by 李江波 on 2017/11/2.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import UIKit

class LEEStareAlertView: UIView {

    let  cellId = "LEEStartAlertCellId"
    
    public var zhuNum: Int?
    public var resultArr: [String]?
    
    @IBOutlet weak var tableV: UITableView!
    
    override func awakeFromNib() {
        tableV.register(UINib.init(nibName: "LEEStartAlertCell", bundle: nil), forCellReuseIdentifier: cellId)
        
    }
    @IBAction func closeAlertAction(_ sender: Any) {
        self.removeFromSuperview()
    }
    
}

extension LEEStareAlertView: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return zhuNum ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LEEStartAlertCell
        
        cell.groupNum = indexPath.row + 1
        cell.groupStr = resultArr?[indexPath.row]
        return cell
    }
    
}

