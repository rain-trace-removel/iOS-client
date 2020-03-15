//
//  RTRDefine.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/3.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define TABBAR_HEIGHT SCREEN_HEIGHT/10

#define NAVIGATION_BAR_HEIGHT 44

#define IS_IPHONE_X_SERIES ((rtr_statusBarFrame.size.height == 44.0f) ? (YES):(NO))

#define STATUS_BAR_HEIGHT (IS_IPHONE_X_SERIES ? 44 : 20)

#define RTRColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define rtr_statusBarFrame (@available(iOS 13.0, *) ? [UIApplication  sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame : [UIApplication sharedApplication].statusBarFrame)

#define rtr_isEmptyString(str) (!str || str==NULL || str ==nil || str.length==0)

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#import <UIKit/UIKit.h>

@interface RTRDefine


@end
