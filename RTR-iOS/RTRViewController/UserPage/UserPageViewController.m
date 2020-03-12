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

@interface UserPageViewController() <UserInfoViewDelegate, RTRImgDerainNetDelegate>

@property(nonatomic, strong) UserInfoView *userInfoView;
@property(nonatomic, strong) UserPageViewModel *userPageViewModel;
@property(nonatomic, strong) UILabel *label;

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
    [self.view addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(30);
    }];
    [self.label setText:@"等待指令"];
    [self.label sizeToFit];
}

- (void)addUserInfoView {
    [self.view addSubview:self.userInfoView];
}

#pragma mark UserInfoViewDelegate

- (void)userDidClickedLoginButton {
    NSLog(@"userDidClickedLoginButton");

    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController pushViewController:[[LoginPageViewController alloc] initWithViewModel:[[LoginPageViewModel alloc] init]] animated:YES];

    
    
    // 测试用
//    [self.userInfoView setBackgroundImg:nil];
//    [self.label setText:@"正在请求图片去雨"];
//    RTRImgDerainNet *imgderainnet = [[RTRImgDerainNet alloc] init];
//    imgderainnet.delegate = self;
//    [imgderainnet rtr_ImageDerainProcess];
}

#pragma mark RTRImgDerainNetDelegate

- (void)didFinishedImageDerain:(BOOL)success withDerainedImage:(UIImage *)image {
    if (success) {
        [self.userInfoView setBackgroundImg:image];
        [self.label setText:@"图片去雨成功"];
        [self.label sizeToFit];
    } else {
        [self.userInfoView setBackgroundImg:nil];
        [self.label setText:@"图片去雨失败"];
        [self.label sizeToFit];
    }
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




@end
