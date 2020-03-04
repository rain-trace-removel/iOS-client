//
//  UITabBarController+Base.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/2/25.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTRTabBarItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITabBarController (Base) <RTRTabBarItemDelegate>

@property(nonatomic, strong) UIView *RTRTabBar;
@property(nonatomic, copy) NSMutableArray *tabBarItemTags;
@property(nonatomic, copy) NSMutableArray *tabBarItemImages;
@property(nonatomic, copy) NSMutableArray *RTRTabBarItemArray;
@property(nonatomic, copy) NSMutableArray *tabPageVCArray;


- (void)reloadViewWithTags:(NSMutableArray *)tags Images:(NSMutableArray *)images VCArray:(NSMutableArray *)VCArray;

@end

NS_ASSUME_NONNULL_END
