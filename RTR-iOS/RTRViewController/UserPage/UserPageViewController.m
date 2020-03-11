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

@interface UserPageViewController()

@property(nonatomic, strong) UserInfoView *userInfoView;
@property(nonatomic, strong) UserPageViewModel *userPageViewModel;

@end

@implementation UserPageViewController

- (void)viewDidLoad {
    [self reloadViewModel];
}

- (instancetype)initWithViewModel: (UserPageViewModel*)viewModel {
    self = [super init];
    if(self) {
        self.userPageViewModel = viewModel;
    }
    return self;
}

- (void)reloadViewModel {
    // reload userPageViewModel
    
    [self setupView];
}

- (void)setupView {
    [self.view setFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-TABBAR_HEIGHT)];
    [self.view setBackgroundColor:[UIColor yellowColor]];
    [self addUserInfoView];
}

- (void)addUserInfoView {
    [self.view addSubview:self.userInfoView];
}

- (UserInfoView *)userInfoView {
    if (_userInfoView == nil) {
        _userInfoView = [[UserInfoView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, 300-STATUS_BAR_HEIGHT) andUserInfoModel:self.userPageViewModel.userInfoModel];
    }
    return _userInfoView;
}




@end
