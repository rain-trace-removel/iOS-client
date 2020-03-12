//
//  LoginPageViewController.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/12.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginPageViewController.h"
#import "Masonry/Masonry.h"
#import "Colours.h"
#import "UIViewController+BackButtonHandler.h"

@interface LoginPageViewController()

@property(nonatomic, strong) LoginPageViewModel *loginPageViewModel;

@property(nonatomic, strong) UIButton *loginButton;
@property(nonatomic, strong) UILabel *loginTitleLabel;
@property(nonatomic, strong) UITextField *usernameInput;
@property(nonatomic, strong) UITextField *passwordInput;

@end

@implementation LoginPageViewController

- (instancetype)initWithViewModel: (LoginPageViewModel *)viewModel {
    self = [super init];
    if(self) {
        self.loginPageViewModel = viewModel;
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad {
    [self reloadViewModel];
}

- (void)reloadViewModel {
    // reload userPageViewModel
    
    [self setupView];
}

- (void)setupView {
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.loginTitleLabel];
    [self.view addSubview:self.usernameInput];
    [self.view addSubview:self.passwordInput];
}

#pragma mark BackButtonHandlerProtocol

- (BOOL)navigationShouldPopOnBackButton {
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController popViewControllerAnimated:YES];
    return YES;
}


#pragma mark Getter & Setter

- (UILabel *)loginTitleLabel {
    if(_loginTitleLabel == nil){
        _loginTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 30)];
        _loginTitleLabel.textColor = [UIColor blackColor];
        _loginTitleLabel.textAlignment = NSTextAlignmentCenter;
        _loginTitleLabel.font = [UIFont systemFontOfSize:20];
        [_loginTitleLabel setText:@"登陆你的头条，掌握昨日信息"];
    }
    return _loginTitleLabel;
}

- (UITextField *)usernameInput {
    if(_usernameInput == nil){
        _usernameInput = [[UITextField alloc] initWithFrame:CGRectMake(50, 160, self.view.frame.size.width - 100, 35)];
        _usernameInput.borderStyle = UITextBorderStyleRoundedRect;
        _usernameInput.font = [UIFont systemFontOfSize:14];
        _usernameInput.layer.cornerRadius = 17.5;
        _usernameInput.layer.masksToBounds = YES;
        [_usernameInput.layer setBorderWidth:1];
        [_usernameInput setAutocorrectionType:UITextAutocorrectionTypeNo];
        [_usernameInput setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [_usernameInput.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.alignment = NSTextAlignmentCenter;
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:@"用户名" attributes:@{NSForegroundColorAttributeName:[UIColor black50PercentColor], NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:style}];
        [_usernameInput setAttributedPlaceholder: attri];
        [_usernameInput setAttributedPlaceholder: attri];
        [_usernameInput setTextAlignment: NSTextAlignmentCenter];
    }
    return _usernameInput;
}

- (UITextField *)passwordInput {
    if(_passwordInput == nil){
        _passwordInput = [[UITextField alloc] initWithFrame:CGRectMake(50, 220, self.view.frame.size.width - 100, 35)];
        _passwordInput.borderStyle = UITextBorderStyleRoundedRect;
        _passwordInput.font = [UIFont systemFontOfSize:14];
        _passwordInput.layer.cornerRadius = 17.5;
        _passwordInput.layer.masksToBounds = YES;
        _passwordInput.secureTextEntry = YES;
        [_passwordInput.layer setBorderWidth:1];
        [_passwordInput setAutocorrectionType:UITextAutocorrectionTypeNo];
        [_passwordInput setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [_passwordInput.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.alignment = NSTextAlignmentCenter;
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSForegroundColorAttributeName:[UIColor black50PercentColor], NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:style}];
        [_passwordInput setAttributedPlaceholder: attri];
        [_passwordInput setTextAlignment: NSTextAlignmentCenter];
    }
    return _passwordInput;
}

- (UIButton *)loginButton {
    if(_loginButton == nil){
        _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 280, self.view.frame.size.width - 100, 35)];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_loginButton setBackgroundColor: [UIColor infoBlueColor]];
        
        [_loginButton.layer setCornerRadius: 17.5];
        [_loginButton addTarget:self action:@selector(LoginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}


@end
