//
//  UIImage+Extension.swift
//  HD_PublicLib_Example
//
//  Created by 波 on 2018/3/2.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
extension UIImage {
    /// 原图
   func Original() -> UIImage {
        return self.withRenderingMode(.alwaysOriginal)
    }
    /**
     resize and crop image
     
     - parameter toSize: destnation size
     
     - returns: destination image
     */
    func resizeAndCropImage(toSize: CGSize)-> UIImage{
        
        let widthFactor = toSize.width / self.size.width
        let heightFactor =  toSize.height / self.size.height
        
        var positionX:CGFloat = 0
        var positionY:CGFloat = 0
        let scaleFactor = widthFactor > heightFactor ? widthFactor : heightFactor
        
        let scaleWidth = scaleFactor * self.size.width
        let scaleHeight = scaleFactor * self.size.height
        
        if widthFactor > heightFactor {
            positionY = (toSize.height - scaleHeight) * 0.5
        } else {
            positionX = (toSize.width - scaleWidth) * 0.5
        }
        
        UIGraphicsBeginImageContext(toSize)
        self.draw(in: CGRect(x: positionX, y: positionY, width: scaleWidth, height: scaleHeight))
        
        return UIGraphicsGetImageFromCurrentImageContext()!
        
    }
    
    func scaleToSize(size:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    /// 改变图片颜色
    func changeColor(color:UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)//kCGBlendModeNormal
        context?.setBlendMode(.normal)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context?.clip(to: rect, mask: self.cgImage!);
        color.setFill()
        context?.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    static func imageFromColor(color: UIColor, viewSize: CGSize? = CGSize(width: 1, height: 1)) -> UIImage{
        let rect: CGRect = CGRect(x: 0, y: 0, width: (viewSize?.width)!, height: (viewSize?.height)!)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext()
        return image!
    }
}
