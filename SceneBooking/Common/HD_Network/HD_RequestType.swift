//
//  HD_RequestType.swift
//  HD_Network_Example
//
//  Created by 波 on 2018/1/31.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import Moya

protocol  HD_RequestType: TargetType {
    var parameters: [String: Any]? {
        get
    }
}

extension HD_RequestType{
    var isParamsShouldWrap : Bool{
        return false
    }
    
    var baseURL: URL{
        return URL(string:UrlHost)! 
    }
    
    // 默认 header
    var headers: [String : String]? {
        return ["appType":"iOS"]
    }
    //请求方式 默认post
    var  method: Moya.Method  {
        return .post
    }
    
    // 默认
    var task: Task {
        if parameters == nil {
            return Task.requestPlain
        } else {
            if isParamsShouldWrap == true { //需要包装
                //在这里统一包data
                let data : NSData! = try? JSONSerialization.data(withJSONObject: parameters!, options: []) as NSData
                let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)! as String
                return Task.requestParameters(parameters: ["data": JSONString], encoding: URLEncoding.default)
            } else {
                return Task.requestParameters(parameters: parameters!, encoding: URLEncoding.default)
            }
        }
    }
    
    //测试使用的不用理会
    var sampleData: Data {
        let dictionary = self.parameters
        let data : Data! = try? JSONSerialization.data(withJSONObject: dictionary ?? [], options: [])
        return data as Data
    }
}

