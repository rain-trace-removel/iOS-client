//
//  UIView+Location.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/7.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import "UIView+Location.h"

@implementation UIView (Location)

- (CGFloat)left {
    return self.frame.origin.x;
}

- (CGFloat)centerX {
    return self.frame.origin.x + self.frame.size.width/2;
}

@end
