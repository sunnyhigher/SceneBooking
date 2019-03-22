//
//  HD_NetIndicaterPlugin.swift
//  HD_Network_Example
//
//  Created by 波 on 2018/2/1.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import Moya
import AlamofireNetworkActivityIndicator

class HD_NetIndicaterPlugin: PluginType {
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest{
        
        guard let tar = target as? HD_RequestType else {
            return request
        }
        print("+++++++请求的信息+++++++")
        print("请求路径:\(tar.baseURL.appendingPathComponent(tar.path))")
        print("请求方式:\(tar.method)")
        if  tar.parameters != nil {
            print("请求参数:\(String(describing: tar.parameters!))")
        }else{
            print("没有参数");
        }
        print("++++++++++++++")
        return request
    }
    
    func willSend(_ request: RequestType, target: TargetType){
        
        NetworkActivityIndicatorManager.shared.isEnabled = true
        
    }
    
    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType){
        NetworkActivityIndicatorManager.shared.isEnabled = false
        
        #if DEBUG
        if (target as? HD_RequestType) != nil{
            switch result{
            case .failure(let error):
                self.showPar("失败" + "\(error.response?.statusCode ?? -3)" , target.baseURL.absoluteString + "/" +  "\(target.path)"  + "\(error.errorDescription ?? "波 未知")")
                break
            default:
                break
            
            }
            
        }
        #endif
    }
    
    func showPar(_ title: String, _ str  : String?) {
        
    }
}
