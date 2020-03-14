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

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hasLogin = NO;
        self.name = @"";
        self.token = @"";
        self.avatar = @"";
    }
    return self;
}

@end
