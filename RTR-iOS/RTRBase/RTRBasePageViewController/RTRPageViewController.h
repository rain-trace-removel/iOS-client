//
//  RTRPageViewController.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/16.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTRTabBarItem.h"


@interface RTRPageViewController : UIViewController

@property(nonatomic, strong) UIPageViewController *pageViewController;
@property(nonatomic, strong) UIView *RTRTabBar;
@property(nonatomic, strong) NSMutableArray *tabBarItemTags;
@property(nonatomic, strong) NSMutableArray *tabBarItemImages;
@property(nonatomic, strong) NSMutableArray *RTRTabBarItemArray;
@property(nonatomic, strong) NSMutableArray *tabPageVCArray;
@property(nonatomic, strong) UIView *whiteBlock;


- (void)reloadViewWithTags:(NSMutableArray *)tags Images:(NSMutableArray *)images VCArray:(NSMutableArray *)VCArray;

@end
