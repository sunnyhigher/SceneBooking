//
//  BaseConst.swift
//  HouDaAnalysis
//
//  Created by 波 on 2017/11/1.
//  Copyright © 2017年 厚大经分. All rights reserved.
//

import UIKit

/// TODO: 每次上线前需要修改

var UrlHost = "http://47.95.242.241/blu/"

let kScreenW = UIScreen.main.bounds.size.width
let kScreenH = UIScreen.main.bounds.size.height
let kScreen = UIScreen.main.bounds
let kScale = Int(UIScreen.main.scale)

let  GPStatusBarH = UIApplication.shared.statusBarFrame.size.height

let window = UIApplication.shared.keyWindow!

let myAppDelegate = (UIApplication.shared.delegate) as! AppDelegate

/// 苹果商店版本号
var appStoreVersion = "0.0.0"

/// 宽度系数比
let scaleWidth : CGFloat = kScreenW / 375.0

/// iPhoneX 系列机型
let kIPhoneX = kScreenW >= 375 && kScreenH >= 812 && (UIDevice.current.systemVersion as NSString).floatValue >= Float(11.0) && !(UIDevice.current.model as NSString).isEqual(to: "iPad")

// MARK: - 适配iponeX 的64 可能是 88
let navTopMagin :CGFloat = kIPhoneX ? 88.0 : 64.0
let statusBatHeight : CGFloat = kIPhoneX ? 44 : 20
// MARK: - 底部的安全区域
let safeBottom :CGFloat = kIPhoneX ? 34.0 : 0.0

// MARK: 闭包
typealias ClickBlockVoid = ()->()
