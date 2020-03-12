//
//  UserInfoView.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/10.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import "UserInfoView.h"
#import "Masonry/Masonry.h"
#import "RTRDefine.h"
#import "Colours.h"

#define BUTTON_HEIGHT 110
#define BUTTON_WIDTH BUTTON_HEIGHT

@interface UserInfoView()

@property(nonatomic, strong) UserInfoModel *userInfoModel;

// 通用
@property(nonatomic, strong) UIImageView *backgroundImageView;
@property(nonatomic, strong) UIButton *userLoginOrIconButton;

// 登录页
@property(nonatomic, strong) UILabel *loginLabel;
// 用户信息页
@property(nonatomic, strong) UILabel *userNameLabel;

@end

@implementation UserInfoView

- (instancetype)initWithFrame:(CGRect)frame andUserInfoModel:(UserInfoModel *)userInfoModel {
    self.userInfoModel = userInfoModel;
    self = [super initWithFrame: frame];
    if (self) {
        [self addSubview:self.backgroundImageView];
        [self addSubview:self.userLoginOrIconButton];
        [self addSubview:self.loginLabel];
        [self addSubview:self.userNameLabel];
        [self reloadView];
    }
    return self;
}


- (void)reloadView {
    if (self.userInfoModel.isUserLogin) {
        [self reloadUserInfoView];
    } else {
        [self reloadUserLoginView];
    }
}

- (void)reloadUserLoginView {
    [self.backgroundImageView setBackgroundColor:[UIColor whiteColor]];
    [self.backgroundImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.width.equalTo(self);
        make.height.equalTo(self);
    }];
    
    [self.userLoginOrIconButton setBackgroundColor:[UIColor pastelBlueColor]];
    [self.userLoginOrIconButton.layer setCornerRadius:BUTTON_HEIGHT/2];
    [self.userLoginOrIconButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.userLoginOrIconButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundImageView);
        make.top.equalTo(self.backgroundImageView).offset(60);
        make.size.mas_equalTo(CGSizeMake(BUTTON_WIDTH, BUTTON_HEIGHT));
    }];
    
    
    [self.loginLabel setTextColor:[UIColor whiteColor]];
    [self.loginLabel setFont:[UIFont systemFontOfSize:18]];
    [self.loginLabel setText:@"LOGIN"];
    [self.loginLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.userLoginOrIconButton);
        make.height.mas_equalTo(20);
    }];
    [self.loginLabel sizeToFit];
}

- (void)reloadUserInfoView {
    
}

- (void)setBackgroundImg:(UIImage *)image {
    [self.backgroundImageView setImage:image];
}

- (void)loginButtonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(userDidClickedLoginButton)]) {
        [_delegate userDidClickedLoginButton];
    }
}

#pragma mark Getter&Setter

- (UIImageView *)backgroundImageView {
    if (_backgroundImageView == nil) {
        _backgroundImageView = [[UIImageView alloc] init];
    }
    return _backgroundImageView;
}

- (UIButton *)userLoginOrIconButton {
    if (_userLoginOrIconButton == nil) {
        _userLoginOrIconButton = [[UIButton alloc] init];
    }
    return _userLoginOrIconButton;
}

- (UILabel *)loginLabel {
    if (_loginLabel == nil) {
        _loginLabel = [[UILabel alloc] init];
    }
    return _loginLabel;
}



@end
