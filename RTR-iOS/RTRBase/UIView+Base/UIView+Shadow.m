//
//  UIView+Shadow.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/7.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import "UIView+Shadow.h"

@implementation UIView (Shadow)


/// 添加四边阴影效果
+ (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    theView.layer.shadowOffset = CGSizeMake(0,0);
    // 阴影透明度，默认0.5
    theView.layer.shadowOpacity = 0.5;
    // 阴影半径，默认5
    theView.layer.shadowRadius = 5;
}


/// 添加单边阴影效果
+ (void)addTopSideShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    theView.layer.shadowColor = theColor.CGColor;
    theView.layer.shadowOffset = CGSizeMake(0,0);
    theView.layer.shadowOpacity = 0.5;
    theView.layer.shadowRadius = 10;
    // 单边阴影 顶边
    float shadowPathWidth = theView.layer.shadowRadius;
    CGRect shadowRect = CGRectMake(0, 0-shadowPathWidth/2.0, theView.bounds.size.width, shadowPathWidth);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:shadowRect];
    theView.layer.shadowPath = path.CGPath;
}

@end
