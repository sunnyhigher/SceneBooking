//
//  HD_ReuqestNetworManager.swift
//  SceneBooking
//
//  Created by 段新瑞 on 2019/3/15.
//  Copyright © 2019 谢樘飞燕. All rights reserved.
//

import UIKit

enum HD_NetworManager {
    case homeList(_ page: Int)
    case messageList()
    case letus()
    case pass(user_id: String, user_pwd: String)
    case feedback(user_id: String, content: String)
    case register(user_username: String, user_pwd: String, user_email: String)
    case login(user_username: String, user_pwd: String)
}

extension HD_NetworManager: HD_RequestType {
    
    var baseURL: URL {
        switch self {
        case .homeList(_):
            return URL(string: "http://api.nail.app887.com/")!
        default:
            return URL(string:UrlHost)!
        }
    }
    
    var path: String {
        switch self {
        case .homeList(_):
            return "api/Articles.action"
        case .messageList():
            return "message.php"
        case .letus():
            return "letus.php"
        case .pass(_,_):
            return "pass.php"
        case .feedback(_,_):
            return "feedback.php"
        case .register(_,_, _):
            return "register.php"
        case .login(_,_):
            return "login.php"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .homeList(let page):
            return ["type": "时尚美甲",
                    "opc": "25",
                    "npc": "\(page)"]
        case .messageList():
            return nil
        case .letus():
            return nil
        case .pass(let user_id, let user_pwd):
            return ["user_id": user_id,
                    "user_pwd": user_pwd]
        case .feedback(let user_id, let content):
            return ["user_id": user_id,
                    "content": content]
        case .register(let user_username, let user_pwd, let user_email):
            return ["user_username": user_username,
                    "user_pwd": user_pwd,
                    "user_email": user_email]
        case .login(let user_username, let user_pwd):
            return ["user_username": user_username,
                    "user_pwd": user_pwd]
        }
    }
}
