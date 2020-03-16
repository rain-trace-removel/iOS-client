//
//  UIImageView+AutoSize.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/16.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (AutoSize)

- (CGSize)setImageViewByImage:(UIImage *)image WithLimitWidth:(CGFloat)width andLimitHeight:(CGFloat)height;

- (CGSize)testss;

@end

NS_ASSUME_NONNULL_END
