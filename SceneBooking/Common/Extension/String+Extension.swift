//
//  String+Extension.swift
//  FRDIntent
//
//  Created by 波 on 2018/3/30.
//

import Foundation

enum HD_ResourceType: String {
    case audio      = "a"
    case video      = "v"
    case download   = "d"
    case play       = "p"
}

extension String{
    func md5Str() -> String{
        return (self as NSString).md5() as String
    }
    
    // 将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    // 将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
    
    func getStrH(font: UIFont, w: CGFloat, number: Int) -> CGFloat {
        let label = UILabel()
        label.text = self
        label.font = font
        label.width = w
        label.numberOfLines = number
        label.sizeToFit()
        return label.height
    }
    
    /**获取字符串高度H*/
    func getNormalStrH(str: String, strFont: CGFloat, w: CGFloat) -> CGFloat {
        return getNormalStrSize(str: str, font: strFont, w: w, h: CGFloat.greatestFiniteMagnitude).height
    }
    /**获取字符串高度H*/
    static func getNormalStrH(str: String, strFont: CGFloat, w: CGFloat) -> CGFloat {
        return str.getNormalStrSize(str: str, font: strFont, w: w, h: CGFloat.greatestFiniteMagnitude).height
    }
    
    /**获取字符串宽度W*/
    func getNormalStrW(str: String, strFont: CGFloat, h: CGFloat) -> CGFloat {
        return getNormalStrSize(str: str, font: strFont, w: CGFloat.greatestFiniteMagnitude, h: h).width
    }
    /**获取字符串宽度W*/
    static func getNormalStrW(str: String, strFont: CGFloat, h: CGFloat) -> CGFloat {
        return str.getNormalStrSize(str: str, font: strFont, w: CGFloat.greatestFiniteMagnitude, h: h).width
    }
    
    /**获取富文本字符串高度H*/
    func getAttributedStrH(attriStr: NSMutableAttributedString, strFont: CGFloat, w: CGFloat) -> CGFloat {
        return getNormalStrSize(attriStr: attriStr, font: strFont, w: w, h: CGFloat.greatestFiniteMagnitude).height
    }
    
    /**获取富文本字符串宽度W*/
    func getAttributedStrW(attriStr: NSMutableAttributedString, strFont: CGFloat, h: CGFloat) -> CGFloat {
        return getNormalStrSize(attriStr: attriStr, font: strFont, w: CGFloat.greatestFiniteMagnitude, h: h).width
    }
    
    /**获取字符串尺寸--私有方法*/
    private func getNormalStrSize(str: String? = nil, attriStr: NSMutableAttributedString? = nil, font: CGFloat, w: CGFloat, h: CGFloat) -> CGSize {
        if str != nil {
            let strSize = (str! as NSString).boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: font)], context: nil).size
            return strSize
        }
        
        if attriStr != nil {
            let strSize = attriStr!.boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, context: nil).size
            return strSize
        }
        
        return CGSize.zero
        
    }
    
    func getAttributedStrH(dict: [NSAttributedString.Key : Any], w: CGFloat) -> CGFloat {
        let strSize = self.boundingRect(with: CGSize(width: w, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: dict, context: nil).size
        return strSize.height
    }
    
    
    /// base 64编码
    func base64Encoding() -> String {
        let plainData = self.data(using: String.Encoding.utf8)
        let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return base64String!
        
    }
    
    ///通过秒来获取时间
    static func getTimeStr(_ time: Int) -> String {
        if time < 60 {
            return "00分\(String(format: "%d", time%60))秒"
        }
        
        if time < 60 * 60 {
            let minute = time / 60
            let second = time % 60
            return "\(String(format: "%d", minute))分\(String(format: "%d", second))秒"
        }
        
        if time < 60 * 60 * 24 {
            let hour = time / 3600
            let minute = time % 3600 / 60
            let second = time % 60
            return "\(hour)小时\(String(format: "%d", minute))分\(String(format: "%d", second))秒"
        }
        
        let day = time / 60 / 60 / 24
        let hour = time % 24 / 3600
        let minute = time % 3600 / 60
        let second = time % 60
        return "\(day)天\(hour)小时\(String(format: "%d", minute))分\(String(format: "%d", second))秒"
    }
    
    /// base 64解码
    func base64Decoding() -> String {
        /// 2进制
        let base64Data = NSData(base64Encoded:self, options:NSData.Base64DecodingOptions.init(rawValue: 0))
        
        /// 字符串
        let stringWithDecode = NSString(data:base64Data! as Data, encoding:String.Encoding.utf8.rawValue)
        return stringWithDecode! as String
    }
    
    /*
    /// 解密播放地址 resource(音频或者视频,默认视频), type:(播放或者下载,默认播放)
    func Decode_AES_CBC(key: String, resource: HD_ResourceType = .video, type: HD_ResourceType = .play) -> String {
        
        var key = resource.rawValue + type.rawValue + key + "LSXY2018103015"
        if key.count > 16 {
            var index = key.startIndex
            index = key.index(index, offsetBy: 16)
            key = String(key[..<index])
        }
        
        let strUrl = self.pregReplace(pattern: "\r|\n|\\s", with: "")
        /// 解密后字符串
        let decodeStr = String.Decode_AES_CBC(str: strUrl, key: key)
        return decodeStr
    }
    
    static func Decode_AES_CBC(str: String, key: String) -> String {
        do {
            let iv = "16-Bytes--String"
            //使用AES-128-CBC加密模式
            let aes = try AES(key: key.bytes, blockMode: CBC(iv: iv.bytes))
            //开始解密2（从加密后的base64字符串解密）
            let decrypted = try str.decryptBase64ToString(cipher: aes)
            return decrypted
        } catch {
            return "解密失败"
        }
    }
    
    static func Encrypt_AES_CBC(UDID: String) -> String {
        /// 加密文本
        let content = UDID + "_LSXYNG"
        
        /// 秘钥
        var key = ""
        if UDID.count > 10 {
            key = (UDID as NSString).substring(from: UDID.count - 10)
            key = key + "LSXY18"
        }
        return Encrypt_AES_CBC(str: content, key: key)
    }
    
    static func Encrypt_AES_CBC(str: String, key: String) -> String {
        do {
            let iv = "16-Bytes--String"
            //使用AES-128-CBC加密模式
            let aes = try AES(key: key.bytes, blockMode: CBC(iv: iv.bytes))
            /// 加密后转Base64
            let decrypt = try str.encryptToBase64(cipher: aes)
            return decrypt!
        } catch {
            return "加密失败"
        }
    }*/
    
    //使用正则表达式替换
    func pregReplace(pattern: String, with: String,
                     options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [],
                                              range: NSMakeRange(0, self.count),
                                              withTemplate: with)
    }
    
    //MARK: - JSON字符串转JSON
    func stringToJson() -> [String : Any] {
    
        do {
            let jsonData = self.data(using: String.Encoding.utf8)
            let dict = try JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers)
            
            return dict as! [String : Any]
            
        } catch _ as NSError {
            
            return [:]
        }
    }
}
