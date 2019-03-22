//
//  HD_MessageViewController.swift
//  SceneBooking
//
//  Created by 段新瑞 on 2019/3/20.
//  Copyright © 2019 谢樘飞燕. All rights reserved.
//

import UIKit

class HD_MessageViewController: HD_BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        let homePath  = NSHomeDirectory()
        print(homePath)
        
        self.navigationItem.title = "消息"
    }
}
