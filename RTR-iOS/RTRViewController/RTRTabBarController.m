//
//  RTRTabBarController.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/2/24.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTRTabBarController.h"
#import "UserPage/UserPageViewController.h"
#import "MainPage/MainPageViewController.h"

@interface RTRTabBarController()

@property(nonatomic, strong) UserPageViewController *userPageVC;
@property(nonatomic, strong) MainPageViewController *mainPageVC;

@end

@implementation RTRTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar setHidden:YES];
    [self reloadViewWithTags:@[@"首页", @"编辑", @"我的"] Images:@[@"icon_home_page", @"icon_edit_page", @"icon_user_page"] VCArray:@[self.mainPageVC, self.mainPageVC, self.userPageVC]];
}

# pragma mark Getter&Setter

- (MainPageViewController *)mainPageVC {
    if(_mainPageVC == nil) {
        _mainPageVC = [[MainPageViewController alloc] init];
    }
    return _mainPageVC;
}

- (UserPageViewController *)userPageVC {
    if(_userPageVC == nil) {
        _userPageVC = [[UserPageViewController alloc] init];
    }
    return _userPageVC;
}



@end
