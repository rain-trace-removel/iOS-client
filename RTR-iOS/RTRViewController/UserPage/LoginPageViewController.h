//
//  LoginPageViewController.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/12.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginPageViewModel.h"



@interface LoginPageViewController:UIViewController

@property(nonatomic, strong) LoginPageViewModel *loginPageViewModel;

- (instancetype)initWithViewModel: (LoginPageViewModel *)viewModel;

@end
