//
//  HD_Network.swift
//  HD_Network_Example
//
//  Created by 波 on 2018/1/30.
//  Copyright © 2018年 CocoaPods. All rights reserved.
// 

import Moya
import HandyJSON
fileprivate let RESULT_CODE = "code"
fileprivate let RESULT_MSG = "message"
fileprivate let RESULT_DATA = "data"


class HD_Network<Target: TargetType>{
    
    enum HD_Error : Swift.Error {
        /// 解析失败
        case ParseJSONError // code =
        /// 解析code错误
        case ParseCodeError
        // 网络请求发生错误
        case RequestFailed
        // 接收到的返回没有response
        case NoResponse
        //服务器返回了一个错误代码
        case UnexpectedResult(resultCode: Int?, resultMsg: String?)
        func code()->Int{
            switch self {
            case .ParseJSONError:
                return -1
            case .ParseCodeError:
                return -1
            case .RequestFailed:
                return -1
            case .NoResponse:
                return -1
            case .UnexpectedResult(let resultCode, _):
                return resultCode ?? -1
            }
            
        }
        func stringMsg() -> String {
            switch self {
            case .ParseJSONError:
                return "解析json出错"
            case .RequestFailed:
                return "暂时无网络,请稍后重试"
            case .NoResponse:
                return "服务器没有响应数据"
                
            case .UnexpectedResult( _, let resultMsg):
                if resultMsg != nil {
                    return resultMsg!
                }else{
                    return "没有返回具体的错误"
                }
            case .ParseCodeError:
                return "未知的code码"
            }
        }
    }
    
    typealias SucessBlockDataWithJson = (_ data: Dictionary<String, Any>?) -> Void
    
    typealias SucessBlock = (_ code : Int?, _ msg:String?,_ data: Any?) -> Void
    
    typealias SucessBlockWithJson = (_ code : Int?, _ msg:String?,_ data: Any?, _ json: NSDictionary?) -> Void
    
    typealias SucessDataList<T> = (_ code : Int?, _ msg:String?,_ data: [T?]?) -> Void
    
    typealias SucessDataJson<T> = (_ code : Int?, _ msg:String?,_ data: T?) -> Void
    
    
    typealias SucessDataListWithJson<T> = (_ code : Int?, _ msg:String?,_ data: [T?]?, _ jsonStr: String?) -> Void
    
    typealias SucessDataJsonWithJson<T> = (_ code : Int?, _ msg:String?,_ data: T?, _ jsonStr: String?) -> Void
    
    typealias FailureBlock = (_ error: HD_Error) -> Void
    
    var plugins :[PluginType]
    init(plugins:[PluginType] = []) {
        self.plugins = plugins
        
    }
    
    
    ///不用任何的处理返回值
    @discardableResult
    func request(_ target: Target,sucess: @escaping SucessBlock ,failure: @escaping FailureBlock ) -> Cancellable?{
        
        return  self.requestWithJson(target, sucess: { (code, msg, data, json) in
            sucess(code, msg, data)
        }, failure: failure)
    }
    
    ///不用任何的处理返回值
    @discardableResult
    func request(_ target: Target,sucess: @escaping SucessBlockDataWithJson ,failure: @escaping FailureBlock ) -> Cancellable?{
        return self.requestDataWithJson(target, sucess: { (json) in
            sucess(json)
        }, failure: failure)
    }
    
    
    ///不用任何的处理返回值
    @discardableResult
    func requestWithJson(_ target: Target,sucess: @escaping SucessBlockWithJson ,failure: @escaping FailureBlock ) -> Cancellable?{
        
        let plugin = HD_NetIndicaterPlugin()
        plugins.append(plugin)
        
        let proviter = MoyaProvider<Target>( requestClosure: requestTimeoutClosure(target: target),plugins: plugins)
        
        return proviter.request(target, completion: { (result) in
            //过滤是否成功
            switch result {
            case let .success(respones):
                do{
                    _ = try respones.filterSuccessfulStatusCodes()
                    let json = try respones.mapJSON() as? Dictionary<String, Any>
                    if let json = json {
                        
                        
                        let data = json[RESULT_DATA]
                        let msg = json[RESULT_MSG] as? String;
                        let jsonObject = json as NSDictionary
                        //处理code
                        var code :Int? = nil
                        if let codestr = json[RESULT_CODE] as? String,let retCode = Int(codestr) {
                            code = retCode
                        } else {
                            failure(HD_Error.ParseCodeError)
                            return
                        }
                        
                        if code != 1 {
                            failure(HD_Error.UnexpectedResult(resultCode: code, resultMsg: msg))
                            return
                        }
                        sucess(code, msg, data, jsonObject)
                    } else {
                        failure(HD_Error.NoResponse)
                        return
                    }
                } catch let error {
                    if error is MoyaError {
                        failure(HD_Error.RequestFailed)
                    } else {
                        failure(HD_Error.ParseJSONError)
                    }
                    
                }
                
                break
            case .failure(_):
                
                failure(HD_Error.RequestFailed)
                break
                
            }
        })
    }
    
    ///不用任何的处理返回值
    @discardableResult
    func requestDataWithJson(_ target: Target,sucess: @escaping SucessBlockDataWithJson ,failure: @escaping FailureBlock ) -> Cancellable?{
        
        let plugin = HD_NetIndicaterPlugin()
        plugins.append(plugin)
        
        let proviter = MoyaProvider<Target>( requestClosure: requestTimeoutClosure(target: target),plugins: plugins)
        
        return proviter.request(target, completion: { (result) in
            //过滤是否成功
            switch result {
            case let .success(respones):
                do{
                    _ = try respones.filterSuccessfulStatusCodes()
                    let json = try respones.mapJSON() as? Dictionary<String, Any>
                    if let json = json {
                        sucess(json)
                    } else {
                        failure(HD_Error.NoResponse)
                        return
                    }
                } catch let error {
                    if error is MoyaError {
                        failure(HD_Error.RequestFailed)
                    } else {
                        failure(HD_Error.ParseJSONError)
                    }
                    
                }
                
                break
            case .failure(_):
                failure(HD_Error.RequestFailed)
                break
                
            }
        })
    }
    
    
    //返回的data是数组的使用这个
    @discardableResult
    func requestDataIsList<T :HandyJSON>(_ target: Target,type:T.Type ,sucess: @escaping SucessDataList<T> ,failure: @escaping FailureBlock ) -> Cancellable?{
        return  self.request(target, sucess: { (code,msg,data) in
            
            let objectsArrays = data as? [Any];
            let objArray = JSONDeserializer<T>.deserializeModelArrayFrom(array: objectsArrays)
            sucess(code,msg,objArray)
            
        }, failure: failure)
        
    }
    /// 返回值是json使用
    @discardableResult
    func requestDataIsJson<T :HandyJSON>(_ target: Target,type:T.Type,sucess: @escaping SucessDataJson<T> ,failure: @escaping FailureBlock ) -> Cancellable?{
        return  self.request(target, sucess: { (code, msg, data) in
            
            let data = data as? [String:Any];
            
            let obj = JSONDeserializer<T>.deserializeFrom(dict: data)
            sucess(code, msg, obj)
        }, failure: failure)
    }
    
    
    // NARK: 返回原 json 串
    //返回的data是数组的使用这个
    @discardableResult
    func requestDataIsListWithJson<T :HandyJSON>(_ target: Target,type:T.Type ,sucess: @escaping SucessDataListWithJson<T> ,failure: @escaping FailureBlock ) -> Cancellable?{
        return  self.requestWithJson(target, sucess: { (code,msg,data, json) in
            
            let objectsArrays = data as? [Any];
            let objArray = JSONDeserializer<T>.deserializeModelArrayFrom(array: objectsArrays)
            let data : NSData! = try? JSONSerialization.data(withJSONObject: json!, options: []) as NSData
            let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)! as String
            sucess(code, msg, objArray, JSONString)
            
        }, failure: failure)
        
    }
    /// 返回值是json使用
    @discardableResult
    func requestDataIsJsonWithJson<T :HandyJSON>(_ target: Target,type:T.Type,sucess: @escaping SucessDataJsonWithJson<T> ,failure: @escaping FailureBlock ) -> Cancellable?{
        return  self.requestWithJson(target, sucess: { (code, msg, data, json) in
            
            let dict = data as? [String:Any];
            let obj = JSONDeserializer<T>.deserializeFrom(dict: dict)
            let data : NSData! = try? JSONSerialization.data(withJSONObject: json!, options: []) as NSData
            let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)! as String
            sucess(code, msg, obj, JSONString)
        }, failure: failure)
    }
    
    //设置一个公共请求超时时间
    private func requestTimeoutClosure<T:TargetType>(target:T) -> MoyaProvider<T>.RequestClosure{
        let requestTimeoutClosure = { (endpoint:Endpoint, done: @escaping MoyaProvider<T>.RequestResultClosure) in
            do{
                var request = try endpoint.urlRequest()
                request.timeoutInterval = 20 //设置请求超时时间
                done(.success(request))
            }catch{
                return
            }
        }
        return requestTimeoutClosure
    }
    
}
