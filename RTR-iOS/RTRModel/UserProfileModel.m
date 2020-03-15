//
//  UserProfileModel.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/15.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import "UserProfileModel.h"

@interface UserProfileModel()

@property(nonatomic, strong) NSMutableArray *settingInfoArray;
@property(nonatomic, strong) NSMutableArray *appAboutInfoArray;

@end

@implementation UserProfileModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        ProfileItem settingItem1 = {@"icon_app", @"个人信息", @"", ItemTypeWithNavigation};
        ProfileItem settingItem2 = {@"icon_app", @"VIP服务", @"", ItemTypeWithNavigation};
        ProfileItem settingItem3 = {@"icon_app", @"版本信息", @"1.0.0", ItemTypeWithAddtion};
        NSValue *s1 = [NSValue valueWithBytes:&settingItem1 objCType:@encode(struct ProfileItem)];
        NSValue *s2 = [NSValue valueWithBytes:&settingItem2 objCType:@encode(struct ProfileItem)];
        NSValue *s3 = [NSValue valueWithBytes:&settingItem3 objCType:@encode(struct ProfileItem)];
        self.settingInfoArray = [NSMutableArray arrayWithObjects:s1, s2, s3, nil];
        
        ProfileItem aboutItem1 = {@"icon_app", @"联系作者", @"", ItemTypeWithNavigation};
        ProfileItem aboutItem2 = {@"icon_app", @"使用条款", @"", ItemTypeWithNavigation};
        ProfileItem aboutItem3 = {@"icon_app", @"隐私条款", @"", ItemTypeWithNavigation};
        ProfileItem aboutItem4 = {@"icon_app", @"开源软件协议", @"", ItemTypeWithNavigation};
        NSValue *a1 = [NSValue valueWithBytes:&aboutItem1 objCType:@encode(struct ProfileItem)];
        NSValue *a2 = [NSValue valueWithBytes:&aboutItem2 objCType:@encode(struct ProfileItem)];
        NSValue *a3 = [NSValue valueWithBytes:&aboutItem3 objCType:@encode(struct ProfileItem)];
        NSValue *a4 = [NSValue valueWithBytes:&aboutItem4 objCType:@encode(struct ProfileItem)];
        self.appAboutInfoArray = [NSMutableArray arrayWithObjects:a1, a2, a3, a4, nil];
        
        self.profileInfoArray = [NSMutableArray arrayWithObjects:self.settingInfoArray, self.appAboutInfoArray, nil];
    }
    return self;
}

- (ProfileItem)readProfileItemWithSection:(NSInteger)section Item:(NSInteger)item {
    if (section == 0) {
        return [self value2profileItem:(NSValue *)[self.settingInfoArray objectAtIndex:item]];
    } else {
        return [self value2profileItem:(NSValue *)[self.appAboutInfoArray objectAtIndex:item]];
    }
}

#pragma mark Private

- (ProfileItem)value2profileItem:(NSValue *)value {
    ProfileItem item;
    [value getValue:&item];
    return item;
}


@end
