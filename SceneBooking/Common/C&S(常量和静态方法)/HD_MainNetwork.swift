//
//  HD_MainNet.swift
//  HouDa_FaKao
//
//  Created by 波 on 2018/4/23.
//  Copyright © 2018年 波波. All rights reserved.
//
//  项目初始化网络请求
//  公共网络请求

import UIKit
import Moya
import HandyJSON

enum HD_NetworkURL {
    /// 获取启动广告信息 使用 HD_AdModel
    case launchAd()
    
    /// app的版本更新
    case checkUpdateVersion()
    
    /// 获取手机号校验正则表达式
    case checkPhoneRule()
}

extension HD_NetworkURL : HD_RequestType {
    
    var parameters: [String : Any]? {
        switch self {
        case .checkUpdateVersion():
            return ["name":"hdlaw","system":"IOS","versionSort": "1"]
        default:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .launchAd:
            return "/api/other/startinformation/anon/get/list"
        case .checkUpdateVersion():
            return "/api/other/appinfo/anon/check/version/update"
        case .checkPhoneRule:
            return "/api/sp/config/spDicConfig/anon/getPhoneRegular"
        }
    }
}

