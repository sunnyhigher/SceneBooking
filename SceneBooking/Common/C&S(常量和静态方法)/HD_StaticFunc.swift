//
//  JFStaticFunc.swift
//  HouDaAnalysis
//
//  Created by 波 on 2017/11/20.
//  Copyright © 2017年 厚大经分. All rights reserved.
//

import UIKit
import MBProgressHUD

enum DisplayType {
    case present
    case push
}

//适配iOS11 的滚动 @available(iOS 11.0, *)
func adaptScrollViewAdjust(_ scrollView :UIScrollView){
    if #available(iOS 11.0, *) {
        scrollView.contentInsetAdjustmentBehavior = .never
    }
}


// MARK: - 适配 ios11的tabelView的section的高度问题
func adaptTabelViewSectionHeight(_ tableView:UITableView) {
    if #available(iOS 11.0, *) {
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
    }
}

// 校验手机号
func verifyPhoneNum(_ phoneNum: String?) -> Bool {
    //判断
    guard let phone = phoneNum else {
        showWindow("请输入手机号")
        return false
    }
    guard phone.isEmpty == false else {
        showWindow("手机号不能为空")
        return false
    }
    
    guard phone.count == 11 else{
        showWindow("请输入正确的手机号")
        return false
    }
    return true
}

func verifyPassword(_ password: String?) -> Bool {
    guard let pass = password else {
        showWindow("请输入密码")
        return false
    }
    
    guard pass.isEmpty == false else {
        showWindow("请输入密码")
        return false
    }
    
    guard pass.count >= 6 && pass.count <= 16 else {
        showWindow("密码长度错误")
        return false
    }
    return true
}

func verifyEmail(_ emailStr: String?) -> Bool {
    guard let email = emailStr else {
        showWindow("请输入邮箱")
        return false
    }
    
    guard email.isEmpty == false else {
        showWindow("请输入邮箱")
        return false
    }
    
    guard email.count > 6 else {
        showWindow("邮箱错误")
        return false
    }
    return true
}

// MARK: - showWindow
func showWindow(_ message: String) {
    showWindowMessage(message, icon: "error.png")
}

func showWindow(_ message: String, icon: String) {
    showWindowMessage(message, icon: icon)
}

fileprivate func showWindowMessage(_ message: String, icon: String) {
    DispatchQueue.main.async {
        MBProgressHUD.hide(for: window, animated: true)
        let hud = MBProgressHUD.showAdded(to: window, animated: true)
        hud.label.text = message
        hud.label.numberOfLines = 0
        hud.customView = UIImageView.init(image: UIImage.init(named: "MBProgressHUD.bundle\(icon)"))
        hud.mode = .customView
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 1.0)
    }
}

//图片的占位图
/// banner 的站位图片
func placeholdeImage() ->UIImage{
    return CommonImage("placeholdeIcon")!
}

///
func userPlaceholdeImage() ->UIImage{
    return CommonImage("guoer_none")!
}

/// 小图公用站位图片
func placeholderPublicImage() -> UIImage {
    return CommonImage("icon_public_placeholder")!
}


func getSourcePath<T>(_ className : T.Type,bundlePath : String,fileName : String) -> String{
    let bundle = Bundle(for: className as! AnyClass)
    let likeImagePath = bundle.path(forResource: bundlePath + ".bundle/" + fileName, ofType: nil)
    return likeImagePath!
}

/*
 * timestamp : 毫秒级时间错
 *
 */
func ChangeDateByTimestamp(_ timestamp : String) -> String {
    
    //获取当前的时间戳
    let currentTime = Date().timeIntervalSince1970
    
    //时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
    let timeStamp = Int(timestamp)
    guard let time = timeStamp else { return "时间" }
    let timeSta:TimeInterval = TimeInterval(time / 1000)
    //时间差
    let reduceTime : TimeInterval = currentTime - timeSta
    //时间差小于60秒
    if reduceTime < 60 {
        return "刚刚"
    }
    //时间差大于一分钟小于60分钟内
    let mins = Int(reduceTime / 60)
    if mins < 60 {
        return "\(mins)分钟前"
    }
    let hours = Int(reduceTime / 3600)
    if hours < 24 {
        let date = NSDate(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter()
        //yyyy-MM-dd HH:mm:ss
        dfmatter.dateFormat="HH:mm"
        
        return dfmatter.string(from: date as Date)
        
        //        return "\(hours)小时前"
    }
    //    let days = Int(reduceTime / 3600 / 24)
    //    if days < 30 {
    //        return "\(days)天前"
    //    }
    
    //不满足上述条件---或者是未来日期-----直接返回日期
    let date = NSDate(timeIntervalSince1970: timeSta)
    let dfmatter = DateFormatter()
    //yyyy-MM-dd HH:mm:ss
    dfmatter.dateFormat="yyyy年MM月dd日 HH:mm:ss"
    return dfmatter.string(from: date as Date)
}


func CommonImage(_ imageName:String)->UIImage?{
    var image: UIImage?
    image = UIImage(named: imageName)
    if image == nil {
        return UIImage()
    }
    return image
}

/// 设置字体
func HDFont_Regular(_ fontsize :CGFloat) ->UIFont{
    if #available(iOS 9.0, *) {
        return UIFont.init(name: "PingFangSC-Regular", size: fontsize)!
    }else {
        return UIFont.systemFont(ofSize: fontsize)
    }
}

func HDFont_Bold(_ fontsize :CGFloat) ->UIFont{
    if #available(iOS 9.0, *) {
        return UIFont.init(name: "PingFangSC-Medium", size: fontsize)!
    }else {
        return UIFont.boldSystemFont(ofSize: fontsize)
    }
}

/// 直接获取对应值
func autoValue(_ width: CGFloat) -> CGFloat {
    return width * scaleWidth
}


func getHTMLStr(_ html : String?) -> String{
    let str = "<html><head><meta name=\"viewport\" content=\"width=devic-width,initial-scale=1,maximum-scale=1\"><style>*{margin:0;padding:0}body{padding-bottom:20px;}</style></head><body>"
        + (html ?? "")
        + "<script>var imgs = document.getElementsByTagName('img');for(i=0;i <imgs.length;i++){myimg = imgs[i];myimg.style=\"width:100%;height:auto\";}</script></body></html>";
    
    return str
}

// MARK: - 打印
func HDlog<T>(_ message: T,
                     file: String = #file,
                     method: String = #function,
                     line: Int = #line)
{
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent.components(separatedBy: ".swift").first ?? "未知"
        print("\n************** printStart *******************\n")
        
        print("\(fileName)[\(line)], \(method):\n\(message)")
        
        print("\n************** printEnd *****************\n")
        
    #endif
}
