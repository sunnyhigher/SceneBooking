//
//  HD_LoginModel.swift
//  SceneBooking
//
//  Created by 段新瑞 on 2019/3/22.
//  Copyright © 2019 谢樘飞燕. All rights reserved.
//

import UIKit

class HD_LoginModel: NSObject {

    typealias successBlockWithCode = (_ code : Int?) -> Void
    class func loadLogin(_ user_username: String, user_pwd: String, success: @escaping successBlockWithCode) {
        let provider = HD_Network<HD_NetworManager>()
        provider.request(HD_NetworManager.login(user_username: user_username, user_pwd: user_pwd), sucess: { (json) in
            guard let json = json else { return }
            let code = json["code"] as! Int
            success(code)
            if code == 1 {
                let userDic = json["user"] as? NSDictionary
                UserDefaults.standard.do {
                    $0.set(userDic?["user_id"], forKey: "user_id")
                    $0.set(userDic?["user_username"], forKey: "user_username")
                    var userHead = userDic?["user_head"] as? String
                    userHead = UrlHost + (userHead ?? "")
                    $0.set(userHead, forKey: "user_head")
                    $0.synchronize()
                }
            } else {
                showWindow("用户名或密码错误")
            }
        }) { (error) in
            showWindow("当前网络不好,请稍后重试~")
        }
    }
}
