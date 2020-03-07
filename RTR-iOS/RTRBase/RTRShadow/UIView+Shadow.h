//
//  UIView+Shadow.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/7.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Shadow)

+ (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor;

+ (void)addTopSideShadowToView:(UIView *)theView withColor:(UIColor *)theColor;

@end

NS_ASSUME_NONNULL_END
