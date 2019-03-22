//
//  HD_LoginViewController.swift
//  SceneBooking
//
//  Created by 段新瑞 on 2019/3/22.
//  Copyright © 2019 谢樘飞燕. All rights reserved.
//

import UIKit

class HD_LoginViewController: HD_BaseVC {

    
    @IBOutlet weak var userNameTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.removeFromSuperview()
        view.backgroundColor = UIColor.mainBg
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    
}

extension HD_LoginViewController {
    @IBAction func closeBtnClick(_ sender: UIButton) {
        
    }
    
    @IBAction func loginBtnClick(_ sender: UIButton) {
        self.view.endEditing(true)
        if verifyPhoneNum(userNameTextField.text) == false { return }
        if verifyPassword(passwordTextField.text) == false { return }
        
        showLoading()
        HD_LoginModel.loadLogin(userNameTextField.text!, user_pwd: passwordTextField.text!) { [weak self] (code) in
            self?.hidenLoading()
            if code == 1{
                myAppDelegate.rootVCForTab()
            }
        }
    }
    
    @IBAction func toRegistBtnClick(_ sender: Any) {
        self.rt_navigationController.pushViewController(HD_RegisterViewController(), animated: true)
    }
}
