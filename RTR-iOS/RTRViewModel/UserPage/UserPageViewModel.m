//
//  UserPageViewModel.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/10.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import "UserPageViewModel.h"

static UserPageViewModel *userPageViewModel = nil;

@implementation UserPageViewModel

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userPageViewModel = [[self alloc] init];
    });
    return userPageViewModel;
}



@end
