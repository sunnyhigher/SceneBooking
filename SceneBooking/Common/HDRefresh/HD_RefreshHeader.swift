//
//  HD_RefreshHeader.swift
//  HD_LawSchool
//
//  Created by 段新瑞 on 2018/10/23.
//  Copyright © 2018 厚大-律师学院. All rights reserved.
//

import UIKit


class HD_RefreshHeader: MJRefreshNormalHeader {

   
    override func prepare() {
        super.prepare()
        
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        self.isAutomaticallyChangeAlpha = true;
        
        // 隐藏时间
        self.lastUpdatedTimeLabel.isHidden = true
        
        // 隐藏状态
        self.stateLabel.isHidden = false
        
        // 设置文字
        self.setTitle("下拉刷新", for: MJRefreshState.idle)
        self.setTitle("松开刷新", for: MJRefreshState.pulling)
        self.setTitle("正在刷新", for: MJRefreshState.refreshing)
        
        // 设置字体
        // self.stateLabel.font = HDFont_Regular(15)

        // 设置颜色
        // self.stateLabel.textColor = UIColor.lightBlackColor
        
        
        
    }
    
}
