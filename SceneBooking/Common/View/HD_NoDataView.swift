//
//  HD_NoDataView.swift
//  HD_Corrigendum_Example
//
//  Created by heiguoliangle on 2018/3/7.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

@objc protocol HD_NoDataViewDelegate : NSObjectProtocol{
    @objc optional func tapNodataView(_ view : HD_NoDataView)
}

class HD_NoDataView: UIView {
    /// 回掉的两种方式
    weak var delegate : HD_NoDataViewDelegate?
    var clickedBlock: ((_ view:HD_NoDataView) -> Void)?
    
    var title : String = "暂无数据"
    var imageName : String? // 默认使用  nodata
    var imageSize : CGSize = CGSize(width: 100, height: 100)
    var imageTopMargin : CGFloat = 100.0
    var titleTop : CGFloat = 10.0
    var image : UIImage = CommonImage("nodata")!
    
    var isCanTouch: Bool = true
    
    lazy var titleAttr : [NSAttributedString.Key : Any] = {
        var p = NSMutableParagraphStyle.init()
        p.alignment = .center
        p.lineSpacing = 5
        return [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor : UIColor(0x999999),NSAttributedString.Key.paragraphStyle:p]
    }()
    
    func reLayout() {
        self.isHidden = false
        isCanTouch = true
        self.superview?.bringSubviewToFront(self)
        setNeedsDisplay()
    }
    
    /// 展示无网络内容
    func showNoNetwork(_ message: String = "暂未连接上网络!\n请连接后点击屏幕重试~") {
        self.title = message
        self.frame = CGRect(x:0, y:0, width:kScreenW, height:kScreenH - navTopMagin)
        self.image = CommonImage("iocn_noNet")!
        self.backgroundColor = UIColor.white
        self.isUserInteractionEnabled = true
        reLayout()
    }
    
    /// 展示无数据内容
    func showNoData() {
        self.title = "暂无数据"
        self.backgroundColor = UIColor.white
        self.frame = CGRect(x:0, y:0, width:kScreenW, height:kScreenH - navTopMagin)
        self.image = CommonImage("nodata")!
        self.isUserInteractionEnabled = false
        reLayout()
    }
    
    
    /// 展示无数据内容
    func showNoDownloadData(_ message: String) {
        self.title = message
        self.backgroundColor = UIColor.white
        self.frame = CGRect(x:0, y:0, width:kScreenW, height:kScreenH - navTopMagin)
        self.image = CommonImage("nodata")!
        self.isUserInteractionEnabled = true
        reLayout()
    }
    
    
    
    
    func showNoData(_ message: String) {
        self.title = message
        self.backgroundColor = UIColor.white
        self.frame = CGRect(x:0, y:0, width:kScreenW, height:kScreenH - navTopMagin)
        self.image = CommonImage("nodata")!
        self.isUserInteractionEnabled = false
        reLayout()
    }
    
    /// 没有登录时显示数据
    func showNoLogin() {
        self.title = "您还没有登录, 请先登录"
        self.backgroundColor = UIColor.white
        self.frame = CGRect(x:0, y:0, width:kScreenW, height:kScreenH - navTopMagin)
        self.image = CommonImage("nodata")!
        self.isUserInteractionEnabled = false
        reLayout()
    }
    
    
    /// 处理 error 情况
    func showError(_ message: String) {
        self.title = message
        self.backgroundColor = UIColor.white
        self.frame = CGRect(x:0, y:0, width:kScreenW, height:kScreenH - navTopMagin)
        self.image = CommonImage("iocn_noNet")!
        self.isUserInteractionEnabled = true
        reLayout()
    }
    
    func hiddenView() {
        self.isHidden = true
    }
    
    convenience init(_ title: String?) {
        self.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: kScreenH - navTopMagin))
        if title != nil {
            self.title = title!
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapView))
        self.backgroundColor = UIColor.clear
        self.isHidden = true
        addGestureRecognizer(tap)
        
    }
    
    @objc func tapView(){
        if isCanTouch == true {
            isCanTouch = false
            clickedBlock?(self)
            self.delegate?.tapNodataView!(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        if let name = imageName,let im = UIImage(named: name) {
            image  = im
        }
        imageSize = image.size
        
        let x = (rect.size.width - (imageSize.width)) * 0.5
        let y = imageTopMargin
        let imageRect = CGRect(x: x, y: y, width: imageSize.width, height: imageSize.height)
        image.draw(in: imageRect, blendMode: CGBlendMode.normal, alpha: 1.0)
        
        let titleRect = (title as NSString).boundingRect(with: CGSize(width: rect.size.width, height: rect.size.height), options: .usesLineFragmentOrigin, attributes: titleAttr, context: nil)
        let titleW = titleRect.size.width
        let titleH = titleRect.size.height
        let titleX = (rect.size.width - titleW) * 0.5
        let drawRect = CGRect(x: titleX, y: y + imageSize.height + titleTop, width: titleW, height: titleH)
        (title as NSString).draw(in: drawRect, withAttributes: titleAttr)
    }   
}
