//
//  UserInfoView.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/10.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoModel.h"

@protocol UserInfoViewDelegate <NSObject>

@required
- (void)userDidClickedLoginButton;

@end

@interface UserInfoView : UIView

@property (nonatomic, weak) id<UserInfoViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame andUserInfoModel:(UserInfoModel *)userInfoModel;

- (void)setBackgroundImg:(UIImage *)image;

@end
