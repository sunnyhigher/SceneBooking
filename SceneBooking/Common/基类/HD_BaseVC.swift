//
//  HD_BaseVC.swift
//  HouDa_FaKao
//
//  Created by 波 on 05/01/2018.
//  Copyright © 2018 波波. All rights reserved.
//

import UIKit
import MBProgressHUD


class HD_BaseVC: UIViewController {
    /*
    /// 空白与无网络展示页面
    lazy var emptyView: HD_NoDataView = {
        let view = HD_NoDataView()
        view.isHidden = true
        return view
    }()
    */
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.grouped)
        adaptTabelViewSectionHeight(tableView)
        return tableView
    }()
    
    /// 无数据
    lazy var noDataView: HD_EmptyView = {
        let view = HD_EmptyView.diy()
        return view!
    }()
    
    /// 无网络
    lazy var noNetworkView: HD_EmptyView = {
        let view = HD_EmptyView.diyEmptyActionView(withTarget: self, action: #selector(reloadNetworkData))
        return view!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.configNavigation()
        // self.view.addSubview(emptyView)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        
        #if DEBUG
        UIApplication.shared.applicationSupportsShakeToEdit = true
        becomeFirstResponder()
        #endif
    }
    
    func configNavigation() {
        self.configNavigationBarColorIsBlue()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    deinit {
        /// 移除通知
        HDlog("deinit: \(self)")
    }

}

// MARK: 导航栏设置
extension HD_BaseVC {
    
    /// 无网络点击调用重新发起网络请求
    @objc func reloadNetworkData() {}
    
    /// 设置导航栏为白色
    func configNavigationBarColorIsWhite() {
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightBlackColor, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)]
    }
    
    /// 设置导航栏为蓝色
    func configNavigationBarColorIsBlue() {
        /*
        self.navigationController?.navigationBar.setBackgroundImage(CommonImage("tab"), for: UIBarMetrics.default)
         */
        self.navigationController?.navigationBar.barTintColor = UIColor.blueColor
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)]
    }
    
    
    /// 设置导航栏返回按钮图片
    override func rt_customBackItem(withTarget target: Any!, action: Selector!) -> UIBarButtonItem! {
        let backBtn: UIButton = UIButton(type: .custom)
        backBtn.setImage(CommonImage("icon_back_white")?.Original(), for: .normal)
        // backBtn.size = CGSize(width: 44, height: 44)
        backBtn.frame = CGRect(x: -20, y: 0, width: 44, height: 44)
        backBtn.contentHorizontalAlignment = .left
        backBtn.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        return UIBarButtonItem(customView: backBtn)
    }
}

// MARK: - 提示语
extension UIViewController {
    
    func showLoading() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
    }
    
    func hidenLoading() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func hidenWindowLoading() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: window, animated: true)
        }
    }
    
    
    func showSuccess(_ message: String = "成功") {
        self.showMessage(message, icon: "success.png")
    }
    
    func showError(_ message: String = "失败") {
        self.showMessage(message, icon: "error.png")
    }
    
    func showText(_ message: String) {
        self.showTextMessage(message, icon: "error.png")
    }
    
    func showWindow(_ message: String) {
        self.showWindowMessage(message, icon: "error.png")
    }
    

    func showWindowLoading(_ message: String) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            MBProgressHUD.hide(for: window, animated: true)
            let hud = MBProgressHUD.showAdded(to: window, animated: true)
            hud.label.text = message
            hud.label.numberOfLines = 0
            hud.label.font = HDFont_Bold(14.0)
            hud.removeFromSuperViewOnHide = true
        }
    }

    
    /// 显示最终都是调的这个
    fileprivate func showMessage(_ message: String, icon: String) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.label.text = message
            hud.customView = UIImageView.init(image: UIImage.init(named: "MBProgressHUD.bundle\(icon)"))
            hud.mode = .customView
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1.0)
        }
    }
    
    /// 显示最终都是调的这个
    fileprivate func showTextMessage(_ message: String, icon: String) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            let hud = MBProgressHUD.showAdded(to: self.view, animated: false)
            hud.label.text = message
            hud.label.numberOfLines = 0
            hud.customView = UIImageView.init(image: UIImage.init(named: "MBProgressHUD.bundle\(icon)"))
            hud.mode = .customView
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1.0)
        }
    }
    
    /// 在window 显示
    fileprivate func showWindowMessage(_ message: String, icon: String) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            MBProgressHUD.hide(for: window, animated: true)
            let hud = MBProgressHUD.showAdded(to: window, animated: false)
            hud.label.text = message
            hud.label.numberOfLines = 0
            hud.customView = UIImageView.init(image: UIImage.init(named: "MBProgressHUD.bundle\(icon)"))
            hud.mode = .customView
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1.0)
        }
    }
}


