//
//  HD_RegisterViewController.swift
//  SceneBooking
//
//  Created by 段新瑞 on 2019/3/22.
//  Copyright © 2019 谢樘飞燕. All rights reserved.
//

import UIKit

class HD_RegisterViewController: HD_BaseVC {

    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.removeFromSuperview()
        view.backgroundColor = UIColor.mainBg
        self.navigationItem.title = "注册"
    }

    @IBAction func registBtnClick(_ sender: Any) {
        view.endEditing(true)
        if verifyPhoneNum(phoneNumberTextField.text) == false { return }
        
        if verifyPassword(passwordTextField.text) == false { return }
        
        if verifyEmail(emailTextfield.text) == false { return }
        
        showLoading()
        let provider = HD_Network<HD_NetworManager>()
        provider.request(HD_NetworManager.register(user_username: phoneNumberTextField.text!, user_pwd: passwordTextField.text!, user_email: emailTextfield.text!), sucess: { (json) in
            guard let json = json else { return }
            let code = json["code"] as! Int
            if code == 1 {
                HD_LoginModel.loadLogin(self.phoneNumberTextField.text!, user_pwd: self.passwordTextField.text!, success: { [weak self] (code) in
                    self?.hidenLoading()
                    myAppDelegate.rootVCForTab()
                })
            } else if code == 2 {
                self.hidenLoading()
                self.showText("注册失败,请重新注册")
            } else {
                self.hidenLoading()
                self.showText("用户名已存在")
            }
            
            HDlog(json)
        }) { (error) in
            self.hidenLoading()
            self.showText("当前网络不好,请稍后重试~")
        }
        
    }
    
    
    
}
