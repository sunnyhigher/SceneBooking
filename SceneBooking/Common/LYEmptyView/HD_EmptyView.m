//
//  DemoEmptyView.m
//  LYEmptyViewDemo
//
//  Created by liyang on 2017/12/1.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "HD_EmptyView.h"
#define MainColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@implementation HD_EmptyView

+ (instancetype)diyEmptyView{
    
    return [HD_EmptyView emptyViewWithImageStr:@"noData"
                                       titleStr:@"暂无数据"
                                      detailStr:@"请稍后再试!"];
}

+ (instancetype)diyEmptyActionViewWithTarget:(id)target action:(SEL)action{

    return [HD_EmptyView emptyActionViewWithImageStr:@"noNetwork"
                                             titleStr:@"无网络连接"
                                            detailStr:@"请检查你的网络连接是否正确!"
                                          btnTitleStr:@"重新加载"
                                               target:target
                                               action:action];
}

- (void)prepare{
    [super prepare];
    
    self.autoShowEmptyView = NO;
    
    self.titleLabTextColor = MainColor(180, 30, 50);
    self.titleLabFont = [UIFont systemFontOfSize:18];
    
    self.detailLabTextColor = MainColor(80, 80, 80);
}

@end
