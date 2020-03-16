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
#import "RTRDefine.h"
#import "YBImageBrowserTipView.h"
#import "RLog.h"

@interface LoginPageViewController()

@property(nonatomic, strong) UIImageView *appIcon;
@property(nonatomic, strong) UIButton *loginButton;
@property(nonatomic, strong) UILabel *loginTitleLabel;
@property(nonatomic, strong) UITextField *usernameInput;
@property(nonatomic, strong) UITextField *passwordInput;
@property(nonatomic, strong) UITextField *againPasswordInput;
@property(nonatomic, strong) UISegmentedControl *loginStyleSwitchButton;

@end

@implementation LoginPageViewController

- (instancetype)initWithViewModel: (LoginPageViewModel *)viewModel {
    self = [super init];
    if(self) {
        self.loginPageViewModel = viewModel;
        [self.view setBackgroundColor:[UIColor whiteColor]];
        [self addTapGesture];
    }
    return self;
}

- (void)viewDidLoad {
    [self.view addSubview:self.appIcon];
    [self.view addSubview:self.loginTitleLabel];
    [self.view addSubview:self.usernameInput];
    [self.view addSubview:self.passwordInput];
    [self.view addSubview:self.againPasswordInput];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.loginStyleSwitchButton];
    [self setupView];
}

- (void)loadViewModel {
    // reload userPageViewModel
    self.loginPageViewModel = [[LoginPageViewModel alloc] init];
    self.loginPageViewModel.loginStyle = RTRLoginStyleLogin;
    [self reloadView];
}

- (void)setupView {
    [self.appIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(60+STATUS_BAR_HEIGHT+NAVIGATION_BAR_HEIGHT);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(64, 64));
    }];
    
    [self.loginTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.appIcon.mas_bottom).offset(30);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 30));
    }];
    
    [self.usernameInput mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginTitleLabel.mas_bottom).offset(30);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-100, 35));
    }];
    
    [self.passwordInput mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.usernameInput.mas_bottom).offset(30);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-100, 35));
    }];
    
    [self.againPasswordInput setHidden:YES];
    
    [self.loginButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordInput.mas_bottom).offset(30);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-100, 35));
    }];
    
    [self.loginStyleSwitchButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordInput.mas_bottom).offset(180);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(150, 35));
    }];
}

- (void)reloadView {
    if (self.loginPageViewModel.loginStyle == RTRLoginStyleLogin) {
        [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
            [self.againPasswordInput setHidden:YES];
             [self.loginButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                 make.top.equalTo(self.passwordInput.mas_bottom).offset(30);
                 make.centerX.equalTo(self.view);
                 make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-100, 35));
             }];
            [self.view layoutIfNeeded];
        }];
       
    } else {
        [self.loginButton setTitle:@"注册" forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
           [self.againPasswordInput mas_remakeConstraints:^(MASConstraintMaker *make) {
               make.top.equalTo(self.passwordInput.mas_bottom).offset(30);
               make.centerX.equalTo(self.view);
               make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-100, 35));
           }];
           [self.loginButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.againPasswordInput.mas_bottom).offset(30);
                make.centerX.equalTo(self.view);
                make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-100, 35));
            }];
           [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self.againPasswordInput setHidden:NO];
        }];
    }
}

#pragma mark BackButtonHandlerProtocol

- (BOOL)navigationShouldPopOnBackButton {
    [self popThisViewController];
    return YES;
}

#pragma mark SenderAction

-(void)indexDidChangeForSegmentedControl:(UISegmentedControl *)sender {
    [self.loginPageViewModel loginStyleChange:((sender.selectedSegmentIndex == 0)?RTRLoginStyleLogin:RTRLoginStyleRegister)];
    [self reloadView];
}

- (void)LoginButtonClick:(id)sender {
    NSLog(@"LoginButtonClick");
    RTRResponseTypeCode responseCode = [self.loginPageViewModel responseWhenClickedLoginButtonWithUserName:self.usernameInput.text
                                                                                                  password:self.passwordInput.text
                                                                                           confirmPassword:self.againPasswordInput.text
                                                                                                   success:^(NSURLSessionDataTask *task, id responseObject)
    {
        if (self.loginPageViewModel.loginStyle == RTRLoginStyleLogin) {
            [[UIApplication sharedApplication].keyWindow yb_showHookTipView:[NSString stringWithFormat:@"欢迎登录, %@", self.usernameInput.text]];
            [self popThisViewController];
        } else {
            // 注册成功，直接后台帮忙登录
            self.loginPageViewModel.loginStyle = RTRLoginStyleLogin;
            [self LoginButtonClick:sender];
        }
    }
                                                                                                   failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        if (self.loginPageViewModel.loginStyle == RTRLoginStyleLogin) {
            [[UIApplication sharedApplication].keyWindow yb_showForkTipView:@"登录失败"];
        } else {
            [[UIApplication sharedApplication].keyWindow yb_showForkTipView:@"注册失败"];
        }
    }];
    
    // 根据code进行视觉响应
    switch (responseCode) {
        case RTRResponseTypeUsernameEmpty:
            [[UIApplication sharedApplication].keyWindow yb_showForkTipView:@"用户名为空"];
            break;
        case RTRResponseTypePasswordEmpty:
            [[UIApplication sharedApplication].keyWindow yb_showForkTipView:@"密码为空"];
            break;
        case RTRResponseTypeConfirmPasswordNotMatch:
            [[UIApplication sharedApplication].keyWindow yb_showForkTipView:@"两次密码输入不一致"];
            break;
        default:
            break;
    }
}

#pragma mark Private

- (void)popThisViewController {
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reKeyBoard)];
    [self.view addGestureRecognizer:tap];
}

- (void)reKeyBoard
{
    [self.usernameInput resignFirstResponder];
    [self.passwordInput resignFirstResponder];
    [self.againPasswordInput resignFirstResponder];
}

#pragma mark Getter & Setter

- (UILabel *)loginTitleLabel {
    if(_loginTitleLabel == nil){
        _loginTitleLabel = [[UILabel alloc] init];
        _loginTitleLabel.textColor = [UIColor blackColor];
        _loginTitleLabel.textAlignment = NSTextAlignmentCenter;
        _loginTitleLabel.font = [UIFont systemFontOfSize:20];
        [_loginTitleLabel setText:@"登陆Keepic，让音视频更精彩"];
    }
    return _loginTitleLabel;
}

- (UITextField *)usernameInput {
    if(_usernameInput == nil){
        _usernameInput = [[UITextField alloc] init];
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
        _passwordInput = [[UITextField alloc] init];
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
        _loginButton = [[UIButton alloc] init];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_loginButton setBackgroundColor: [UIColor pastelBlueColor]];
        
        [_loginButton.layer setCornerRadius: 17.5];
        [_loginButton addTarget:self action:@selector(LoginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIImageView *)appIcon {
    if (_appIcon == nil) {
        _appIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_app"]];
    }
    return _appIcon;
}

- (UISegmentedControl *)loginStyleSwitchButton {
    if (_loginStyleSwitchButton == nil) {
        _loginStyleSwitchButton = [[UISegmentedControl alloc] initWithItems:@[@"登录", @"注册"]];
        _loginStyleSwitchButton.tintColor = [UIColor infoBlueColor];
        _loginStyleSwitchButton.selectedSegmentIndex = 0;
        [_loginStyleSwitchButton addTarget:self action:@selector(indexDidChangeForSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    }
    return _loginStyleSwitchButton;
}

- (UITextField *)againPasswordInput {
    if(_againPasswordInput == nil){
        _againPasswordInput = [[UITextField alloc] init];
        _againPasswordInput.borderStyle = UITextBorderStyleRoundedRect;
        _againPasswordInput.font = [UIFont systemFontOfSize:14];
        _againPasswordInput.layer.cornerRadius = 17.5;
        _againPasswordInput.layer.masksToBounds = YES;
        _againPasswordInput.secureTextEntry = YES;
        [_againPasswordInput.layer setBorderWidth:1];
        [_againPasswordInput setAutocorrectionType:UITextAutocorrectionTypeNo];
        [_againPasswordInput setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [_againPasswordInput.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.alignment = NSTextAlignmentCenter;
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:@"重复密码" attributes:@{NSForegroundColorAttributeName:[UIColor black50PercentColor], NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:style}];
        [_againPasswordInput setAttributedPlaceholder: attri];
        [_againPasswordInput setTextAlignment: NSTextAlignmentCenter];
    }
    return _againPasswordInput;
}

@end
