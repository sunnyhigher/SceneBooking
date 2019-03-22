//
//  AppDelegate+extension.swift
//  HouDa_FaKao
//
//  Created by 波 on 2018/2/2.
//  Copyright © 2018年 波波. All rights reserved.
//

import Foundation

extension AppDelegate {
    
    func rootVCForLoginVC() {
        let rootVC = RTRootNavigationController(rootViewControllerNoWrapping: HD_LoginViewController())
        rootVC?.useSystemBackBarButtonItem = false
        rootVC?.transferNavigationBarAttributes = false
        rootVC?.navigationBar.barTintColor = UIColor.blueColor
        self.changeRootVC(rootVC!);
    }
    
    func rootVCForTab() {
        let rootVC = RTRootNavigationController(rootViewControllerNoWrapping: HD_BaseTabBarController.sharedTabbar())
        rootVC?.useSystemBackBarButtonItem = false
        rootVC?.transferNavigationBarAttributes = false
        rootVC?.navigationBar.barTintColor = UIColor.blueColor
        self.changeRootVC(rootVC!);
    }
    
    ///切换根控制器
    func changeRootVC(_ rootVC :UIViewController) {
        rootVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve;
        
        let window = self.window
        let animation :()->Void = {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            window?.rootViewController = rootVC
            UIView.setAnimationsEnabled(oldState)
        }
        
        let v = window! as UIView
        UIView.transition(with: v, duration: 0.5, options: .transitionCrossDissolve, animations: animation, completion: nil)
    }
}
