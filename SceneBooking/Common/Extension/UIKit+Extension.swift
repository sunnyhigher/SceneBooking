//
//  UIKit+Extension.swift
//  News
//
//  Created by 杨蒙 on 2017/12/12.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import CoreText

protocol StoryboardLoadable {}

extension StoryboardLoadable where Self: UIViewController {
    /// 提供 加载方法
    static func loadStoryboard() -> Self {
        return UIStoryboard(name: "\(self)", bundle: nil).instantiateViewController(withIdentifier: "\(self)") as! Self
    }
}

protocol NibLoadable {}

extension NibLoadable {
    static func loadViewFromNib() -> Self {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! Self
    }
}


extension UIView {
    
    /// x
    var x: CGFloat {
        get { return frame.origin.x }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    /// y
    var y: CGFloat {
        get { return frame.origin.y }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
    /// height
    var height: CGFloat {
        get { return frame.size.height }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    
    /// width
    var width: CGFloat {
        get { return frame.size.width }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width  = newValue
            frame = tempFrame
        }
    }
    
    /// size
    var size: CGSize {
        get { return frame.size }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size        = newValue
            frame                 = tempFrame
        }
    }
    
    /// centerX
    var centerX: CGFloat {
        get { return center.x }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x            = newValue
            center                  = tempCenter
        }
    }
    
    /// centerY
    var centerY: CGFloat {
        get { return center.y }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y            = newValue
            center                  = tempCenter;
        }
    }
}

protocol RegisterCellFromNib {}

extension RegisterCellFromNib {
    
    static var identifier: String { return "\(self)" }
    
    static var nib: UINib? { return UINib(nibName: "\(self)", bundle: nil) }
}

extension UITableView {
    /// 注册 cell 的方法
    func HD_registerCell<T: UITableViewCell>(cell: T.Type) where T: RegisterCellFromNib {
        if let nib = T.nib { register(nib, forCellReuseIdentifier: T.identifier) }
        else { register(cell, forCellReuseIdentifier: T.identifier) }
    }
    
    /// 从缓存池池出队已经存在的 cell
    func HD_dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: RegisterCellFromNib {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}

extension UICollectionView {
    /// 注册 cell 的方法
    func HD_registerCell<T: UICollectionViewCell>(cell: T.Type) where T: RegisterCellFromNib {
        if let nib = T.nib {
            register(nib, forCellWithReuseIdentifier: T.identifier)
        }
        else {
            register(cell, forCellWithReuseIdentifier: T.identifier)
        }
        
    }
    
    /// 从缓存池池出队已经存在的 cell
    func HD_dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: RegisterCellFromNib {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
    
    /// 注册头部
    func HD_registerSupplementaryHeaderView<T: UICollectionReusableView>(reusableView: T.Type) where T: RegisterCellFromNib {
        // T 遵守了 RegisterCellOrNib 协议，所以通过 T 就能取出 identifier 这个属性
        if let nib = T.nib {
            register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier)
        } else {
            register(reusableView, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier)
        }
    }
    
    /// 获取可重用的头部
    func HD_dequeueReusableSupplementaryHeaderView<T: UICollectionReusableView>(indexPath: IndexPath) -> T where T: RegisterCellFromNib {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}

extension UIImageView {
    /// 设置图片圆角
    func circleImage() {
        /// 建立上下文
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0)
        /// 获取当前上下文
        let ctx = UIGraphicsGetCurrentContext()
        /// 添加一个圆，并裁剪
        ctx?.addEllipse(in: self.bounds)
        ctx?.clip()
        /// 绘制图像
        self.draw(self.bounds)
        /// 获取绘制的图像
        let image = UIGraphicsGetImageFromCurrentImageContext()
        /// 关闭上下文
        UIGraphicsEndImageContext()
        DispatchQueue.global().async {
            self.image = image
        }
    }
    
}

extension UIColor {
    
    
    convenience init(_ hex:UInt32, _ alpha:CGFloat = 1){
        self.init(red: CGFloat(((hex & 0xFF0000) >> 16))/255.0, green: CGFloat(((hex & 0xFF00) >> 8))/255.0, blue: CGFloat(((hex & 0xFF)))/255.0, alpha: alpha)
    }
    
    // rgb 为 0-255 的浮点数
    convenience init(r: CGFloat,g : CGFloat ,b : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    convenience init(r :CGFloat, g :CGFloat, b :CGFloat, a :CGFloat = 1){
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    convenience init(r: Int,g : Int ,b : Int) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
    convenience init(r: Int, g: Int, b: Int, a: CGFloat = 1){
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: a)
    }
    
    class func randomColor() -> UIColor {
        let random = CGFloat(arc4random_uniform(256))
        return UIColor(r: random, g: random, b: random)
    }
    class func getRGBColor(firstColor : UIColor,endColor : UIColor) -> (CGFloat,CGFloat,CGFloat){
        let fristRGB = firstColor.getRGB()
        let endRGB = endColor.getRGB()
        return (fristRGB.0 - endRGB.0,fristRGB.1 - endRGB.1,fristRGB.2 - endRGB.2)
        
    }
    
    func getRGB() -> (CGFloat, CGFloat, CGFloat) {
        var red : CGFloat = 0
        var green : CGFloat = 0
        var blue : CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        return (red * 255, green * 255, blue * 255)
    }
    
    /// 蓝色 0084ff
    class var blueColor: UIColor {
        return UIColor(0x1296db)
    }
    
    /// 背景灰色 f4f4f4
    class var mainBg: UIColor {
        return UIColor(0xf4f4f4)
    }
    
    /// 浅灰色字体 888888
    class var lowGrayColor: UIColor {
        return UIColor(0x888888)
    }
    
    /// 黑色字体 333333
    class var lightBlackColor: UIColor {
        return UIColor(0x333333)
    }
    
    /// 分割线颜色
    class var lineColor: UIColor {
        return UIColor(0xececec)
    }
    
    /// 一级标题字体颜色
    class var titleColor: UIColor {
        
        return UIColor(r: 51.0, g: 51.0, b: 51.0)
    }
    
    /// 二级标题字体颜色
    
    class var detailColor: UIColor {
        
        return UIColor(r: 102.0, g: 102.0, b: 102.0)
    }
    
}

