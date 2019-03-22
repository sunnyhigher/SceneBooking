//
//  UIView+Designable.h
//  LandCredit
//
//  Created by 段新瑞 on 2017/4/9.
//  Copyright © 2017年 联壁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Designable)

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable UIColor *borderColor;


- (void)setCornerRadius:(UIRectCorner)corners withRadius:(CGFloat)radius;


@end
