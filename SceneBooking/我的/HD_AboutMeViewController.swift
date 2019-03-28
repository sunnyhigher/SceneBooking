//
//  HD_AboutMeViewController.swift
//  SceneBooking
//
//  Created by 段新瑞 on 2019/3/25.
//  Copyright © 2019 谢樘飞燕. All rights reserved.
//

import UIKit

class HD_AboutMeViewController: HD_BaseVC {
    
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customUI()
        self.navigationItem.title = "关于我们"
        self.tableView.removeFromSuperview()
    }
    
    func customUI() {
        let provider = HD_Network<HD_NetworManager>()
        provider.request(HD_NetworManager.letus(), sucess: { (json) in
            self.hidenLoading()
            guard let json = json else { return }
            let code = json["code"] as! Int
            let dict = json["letus"] as! Dictionary<String, Any>
            if code == 1 {
                self.contentLabel.text = dict["letus_content"] as? String
            }
        }) { (error) in
            self.hidenLoading()
            self.showText("网络有误,请稍后重试")
        }
    }
}
