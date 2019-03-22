//
//  UIView+Designable.m
//  LandCredit
//
//  Created by 段新瑞 on 2017/4/9.
//  Copyright © 2017年 联壁. All rights reserved.
//

#import "UIView+Designable.h"

@implementation UIView (Designable)

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius  = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}


- (void)setCornerRadius:(UIRectCorner)corners withRadius:(CGFloat)radius {

    UIBezierPath *bezierpath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    shape.path = bezierpath.CGPath;
    
    self.layer.mask = shape;
}


@end
