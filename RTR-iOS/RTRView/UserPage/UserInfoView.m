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
#import "RTRUserManager.h"
#import <SDWebImage/SDWebImage.h>


#define BUTTON_HEIGHT 110
#define BUTTON_WIDTH BUTTON_HEIGHT

@interface UserInfoView()

// 通用
@property(nonatomic, strong) UIImageView *backgroundImageView;
@property(nonatomic, strong) UIButton *userLoginOrIconButton;
@property(nonatomic, strong) UIVisualEffectView *effectview;

// 登录页
@property(nonatomic, strong) UILabel *loginLabel;
// 用户信息页
@property(nonatomic, strong) UILabel *userNameLabel;

@end

@implementation UserInfoView

- (instancetype)initWithFrame:(CGRect)frame andUserInfoModel:(UserInfoModel *)userInfoModel {
    self = [super initWithFrame: frame];
    if (self) {
        [self addSubview:self.backgroundImageView];
        [self addSubview:self.userLoginOrIconButton];
        [self addSubview:self.loginLabel];
        [self addSubview:self.userNameLabel];
        [self.backgroundImageView addSubview:self.effectview];
        [self reloadView];
    }
    return self;
}

- (void)reloadView {
    if ([[RTRUserManager rtr_shareManager] rtr_isLogin]) {
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
    
    // 毛玻璃
    [self.effectview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.backgroundImageView);
        make.size.equalTo(self.backgroundImageView);
    }];
    [self.effectview setHidden:YES];
    
    
    [self.userLoginOrIconButton setBackgroundColor:[UIColor pastelBlueColor]];
    [self.userLoginOrIconButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundImageView);
        make.top.equalTo(self.backgroundImageView).offset(60);
        make.size.mas_equalTo(CGSizeMake(BUTTON_WIDTH, BUTTON_HEIGHT));
    }];
    
    [self.loginLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.userLoginOrIconButton);
        make.height.mas_equalTo(20);
    }];
    [self.loginLabel sizeToFit];
}

- (void)reloadUserInfoView {
    UserInfoModel *userInfoModel = [RTRUserManager rtr_shareManager].user;
    
    [self.backgroundImageView sd_setImageWithURL:[RTRUserManager rtr_shareManager].user.avatar placeholderImage:[UIImage imageNamed:@"icon_app"] options:SDWebImageRefreshCached];
    [self.backgroundImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.width.equalTo(self);
        make.height.equalTo(self);
    }];
    
    [self.effectview setHidden:NO];
    [self.effectview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.backgroundImageView);
        make.size.equalTo(self.backgroundImageView);
    }];
    
    [self.userLoginOrIconButton sd_setImageWithURL:[RTRUserManager rtr_shareManager].user.avatar forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_app"] options:SDWebImageRefreshCached];
    [self.userLoginOrIconButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundImageView);
        make.top.equalTo(self.backgroundImageView).offset(60);
        make.size.mas_equalTo(CGSizeMake(BUTTON_WIDTH, BUTTON_HEIGHT));
    }];
    
    [self.loginLabel setText:userInfoModel.name];
    [self.loginLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.userLoginOrIconButton);
        make.top.equalTo(self.userLoginOrIconButton.mas_bottom).offset(20);
        make.height.mas_equalTo(20);
    }];
    [self.loginLabel sizeToFit];
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
        _backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _backgroundImageView;
}

- (UIButton *)userLoginOrIconButton {
    if (_userLoginOrIconButton == nil) {
        _userLoginOrIconButton = [[UIButton alloc] init];
        [_userLoginOrIconButton.layer setCornerRadius:BUTTON_HEIGHT/2];
        [_userLoginOrIconButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_userLoginOrIconButton.imageView.layer setCornerRadius:BUTTON_HEIGHT/2];
    }
    return _userLoginOrIconButton;
}

- (UILabel *)loginLabel {
    if (_loginLabel == nil) {
        _loginLabel = [[UILabel alloc] init];
        [_loginLabel setTextColor:[UIColor whiteColor]];
        [_loginLabel setFont:[UIFont systemFontOfSize:18]];
        [_loginLabel setText:@"LOGIN"];
    }
    return _loginLabel;
}

- (UIVisualEffectView *)effectview {
    if (_effectview == nil) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    }
    return _effectview;
}

@end
