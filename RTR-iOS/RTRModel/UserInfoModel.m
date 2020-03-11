//
//  UserInfoModel.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/10.
//  Copyright © 2020 chenbb6. All rights reserved.
//
#import "UserInfoModel.h"
#import "RTRUserManager.h"

@interface UserInfoModel()

@end

@implementation UserInfoModel

- (BOOL)isUserLogin {
    return [[RTRUserManager rtr_shareManager] rtr_isLogin];
}

@end
