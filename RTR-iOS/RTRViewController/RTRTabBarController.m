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
#import "AlbumPage/AlbumPageViewController.h"
#import "RTRDefine.h"

@interface RTRTabBarController()

@property(nonatomic, strong) UserPageViewController *userPageVC;
@property(nonatomic, strong) MainPageViewController *mainPageVC;
@property(nonatomic, strong) AlbumPageViewController *albumPageVC;

@end

@implementation RTRTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar setHidden:YES];
//    [self reloadViewWithTags:@[@"首页", @"编辑", @"我的"] Images:@[@"icon_home_page", @"icon_edit_page", @"icon_user_page"] VCArray:@[self.mainPageVC, self.albumPageVC, self.userPageVC]];
    [self reloadViewWithTags:@[@"首页", @"我的"] Images:@[@"icon_home_page", @"icon_user_page"] VCArray:@[self.mainPageVC, self.userPageVC]];

}

# pragma mark Getter&Setter

- (MainPageViewController *)mainPageVC {
    if(_mainPageVC == nil) {
        _mainPageVC = [[MainPageViewController alloc] initWithViewModel:[MainPageViewModel shareInstance]];
//        [_mainPageVC.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT)];

    }
    return _mainPageVC;
}

- (UserPageViewController *)userPageVC {
    if(_userPageVC == nil) {
        _userPageVC = [[UserPageViewController alloc] initWithViewModel:[UserPageViewModel shareInstance]];
//        [_userPageVC.view setFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT-150)];
    }
    return _userPageVC;
}

- (AlbumPageViewController *)albumPageVC {
    if(_albumPageVC == nil) {
        _albumPageVC = [[AlbumPageViewController alloc] init];
//        [_albumPageVC.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT)];
        
    }
    return _albumPageVC;
}

@end
