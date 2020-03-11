//
//  RTRUserManager.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/10.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import "RTRUserManager.h"
#import "UserInfoModel.h"

static RTRUserManager *userManager = nil;

@interface RTRUserManager()

@property(nonatomic, assign) BOOL isLogin;

@property(nonatomic, strong) UserInfoModel *userInfoModel;

@end

@implementation RTRUserManager

+ (instancetype)rtr_shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userManager = [[self alloc] init];
    });
    return userManager;
}

- (BOOL)rtr_isLogin {
    return NO;
//    return self.isLogin;
}

@end
