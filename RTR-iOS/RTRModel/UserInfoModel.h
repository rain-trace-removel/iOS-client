//
//  UserInfoModel.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/10.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

@property(nonatomic, assign) NSString *name;
@property(nonatomic, assign) NSString *token;
@property(nonatomic, assign) BOOL hasLogin;
@property(nonatomic, assign) NSString *avatar;

@end
