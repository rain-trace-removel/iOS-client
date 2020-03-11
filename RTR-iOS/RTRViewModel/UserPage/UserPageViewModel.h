//
//  UserPageViewModel.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/10.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface UserPageViewModel : NSObject

@property(nonatomic, strong) UserInfoModel *userInfoModel;

+ (instancetype)shareInstance;

@end
