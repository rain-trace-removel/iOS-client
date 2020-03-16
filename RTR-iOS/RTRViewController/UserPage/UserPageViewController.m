//
//  UserPageViewController.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/2/25.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import "UserPageViewController.h"
#import "Masonry/Masonry.h"
#import "RTRDefine.h"
#import "UserInfoView.h"
#import "RTRImgDerainNet.h"
#import "LoginPageViewController.h"
#import "RTRUserManager.h"
#import "UserProfileView.h"

@interface UserPageViewController() <UserInfoViewDelegate>

@property(nonatomic, strong) UserInfoView *userInfoView;
@property(nonatomic, strong) UserProfileView *userProfileView;
@property(nonatomic, strong) UserPageViewModel *userPageViewModel;
@property(nonatomic, strong) UILabel *label;

@end

@implementation UserPageViewController

- (void)viewDidLoad {
    [self setupView];
}

- (instancetype)initWithViewModel: (UserPageViewModel*)viewModel {
    self = [super init];
    if(self) {
        self.userPageViewModel = viewModel;
    }
    return self;
}


- (void)reloadViewModel {
    [self.userPageViewModel requestGettingUserInfoWithBlockSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        [self reloadView];
    } failure:nil];
}

- (void)setupView {
    [self.view setFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-TABBAR_HEIGHT)];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.userInfoView];
    [self.view addSubview:self.userProfileView];
}

- (void)reloadView {
    [self.userInfoView reloadView];
}

#pragma mark Life Cycle

- (void)viewWillAppear:(BOOL)animated {
    [self reloadViewModel];
}
- (void)viewDidAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark UserInfoViewDelegate

- (void)userDidClickedLoginButton {
    NSLog(@"userDidClickedLoginButton");

    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController pushViewController:[[LoginPageViewController alloc] initWithViewModel:[[LoginPageViewModel alloc] init]] animated:YES];
}

#pragma mark Getter&Setter

- (UserInfoView *)userInfoView {
    if (_userInfoView == nil) {
        _userInfoView = [[UserInfoView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, 300-STATUS_BAR_HEIGHT) andUserInfoModel:self.userPageViewModel.userInfoModel];
        _userInfoView.delegate = self;
    }
    return _userInfoView;
}

- (UILabel *)label {
    if (_label == nil) {
        _label = [[UILabel alloc] init];
    }
    return _label;
}

- (UserProfileView *)userProfileView {
    if (_userProfileView == nil) {
        _userProfileView = [[UserProfileView alloc] initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, SCREEN_HEIGHT-300-TABBAR_HEIGHT)];
    }
    return _userProfileView;
}


@end
