//
//  HD_ChangePasswordVC.swift
//  SceneBooking
//
//  Created by 段新瑞 on 2019/3/25.
//  Copyright © 2019 谢樘飞燕. All rights reserved.
//

import UIKit

class HD_ChangePasswordVC: HD_BaseVC {

    @IBOutlet weak var passwFordTextField: UITextField!
    
    @IBOutlet weak var rePasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.removeFromSuperview()
        self.navigationItem.title = "修改密码"
        view.backgroundColor = UIColor.mainBg
    }
    
    @IBAction func savePasswordBtnClick(_ sender: Any) {
        self.view.endEditing(true)
        if verifyPassword(passwFordTextField.text) == false { return }
        if passwFordTextField.text != rePasswordTextField.text {
            showText("两次密码不一致")
            return
        }
    
        showLoading()
        let userId = UserDefaults.standard.string(forKey: "user_id")
        let provider = HD_Network<HD_NetworManager>()
        provider.request(HD_NetworManager.pass(user_id: userId!, user_pwd: rePasswordTextField.text ?? ""), sucess: { (json) in
            self.hidenLoading()
            guard let json = json else { return }
            let code = json["code"] as! Int
            if code == 1 {
                self.showText("修改成功")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1, execute: {
                    self.rt_navigationController.popToRootViewController(animated: true, complete: nil)
                })
            } else {
                self.showText("修改失败,请重试")
            }
            
        }) { (error) in
            self.hidenLoading()
            self.showText("网络有误,请稍后重试")
        }
    }
}
