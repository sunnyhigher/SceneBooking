//
//  HD_RefreshFooter.swift
//  HD_LawSchool
//
//  Created by 段新瑞 on 2018/10/23.
//  Copyright © 2018 厚大-律师学院. All rights reserved.
//

import UIKit

class HD_RefreshFooter: MJRefreshAutoNormalFooter {

    override func prepare() {
        super.prepare()
        
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        self.isRefreshingTitleHidden = true
        
        // 隐藏状态
        self.isAutomaticallyRefresh = false
        
        
        // 设置文字
        self.setTitle("上拉加载更多", for: MJRefreshState.idle)
        self.setTitle("松手开始加载", for: MJRefreshState.pulling)
        self.setTitle("正在加载", for: MJRefreshState.refreshing)
        self.setTitle("", for: MJRefreshState.noMoreData)
        
        // 设置字体
        // self.stateLabel.font = HDFont_Regular(15)
        
        // 设置颜色
        // self.stateLabel.textColor = UIColor.lightBlackColor
        
    }
}
