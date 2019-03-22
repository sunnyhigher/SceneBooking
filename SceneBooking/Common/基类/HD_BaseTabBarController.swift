//
//  HD_BaseTabBarController.swift
//  HD_LawSchool
//
//  Created by 段新瑞 on 2018/10/22.
//  Copyright © 2018 厚大-律师学院. All rights reserved.
//

import UIKit
import CYLTabBarController

class HD_BaseTabBarController: CYLTabBarController {

    
    class func sharedTabbar() -> HD_BaseTabBarController {
        let tabBarVC = HD_BaseTabBarController(viewControllers: self.viewControllers(), tabBarItemsAttributes: self.tabBarItemsAttributesForController())!
        self.customizeTabBarAppearance(tabBarVC)
        return tabBarVC
    }
    
    class func tabBarItemsAttributesForController() -> [[String : String]] {
        let tabBarItemOne = [CYLTabBarItemTitle : "首页",
                                          CYLTabBarItemImage : "tabbar_shouye",
                                          CYLTabBarItemSelectedImage :  "tabbar_shouye_sel"];
        let tabBarItemTwo = [CYLTabBarItemTitle : "消息",
                                           CYLTabBarItemImage :  "tabbar_xiaoxi",
                                           CYLTabBarItemSelectedImage :  "tabbar_xiaoxi_sel"];
        let tabBarItemThree = [CYLTabBarItemTitle : "我的",
                                          CYLTabBarItemImage :  "tabbar_wode",
                                          CYLTabBarItemSelectedImage :  "tabbar_wode_sel"];
        return [tabBarItemOne,tabBarItemTwo,tabBarItemThree]
    }
    
    class func viewControllers() -> [UIViewController] {
        let homeNVC = RTContainerNavigationController(rootViewController: HD_HomeViewController())
        homeNVC.navigationBar.barTintColor = UIColor.blueColor
        
        let learnNVC = RTContainerNavigationController(rootViewController: HD_MessageViewController())
        learnNVC.navigationBar.barTintColor = UIColor.blueColor
        
        let mineNVC = RTContainerNavigationController(rootViewController: HD_MineViewController())
        mineNVC.navigationBar.barTintColor = UIColor.blueColor
        return [homeNVC, learnNVC, mineNVC]
    }
    
    class func customizeTabBarAppearance(_ tabBarController: HD_BaseTabBarController) {
        
        let normalAttrs = [NSAttributedString.Key.foregroundColor: UIColor(0x909090)]
        let selectedAttrs = [NSAttributedString.Key.foregroundColor: UIColor(0x0084ff)]
        
        let tabBar = UITabBarItem.appearance()
        tabBar.setTitleTextAttributes(normalAttrs, for: .normal)
        tabBar.setTitleTextAttributes(selectedAttrs, for: .selected)
        
        
        tabBarController.tabBar.barTintColor = UIColor.white
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.backgroundImage = UIImage.init(named: "tabbar_background")
        tabBarController.tabBar.shadowImage = UIImage.init(named: "tapbar_top_line")
    }
    
    // MARK: 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return getSelectVC().prefersStatusBarHidden
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return getSelectVC().preferredStatusBarStyle
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return getSelectVC().preferredStatusBarUpdateAnimation
    }
    
    func getSelectVC() -> UIViewController {
        return self.viewControllers.safeObject(self.selectedIndex) ?? UIViewController()
    }
    
}
