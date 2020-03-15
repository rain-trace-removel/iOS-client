//
//  UserProfileModel.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/15.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef UserProfileModel_h
#define UserProfileModel_h

typedef enum NSUInteger {
    ItemTypeNormal = 1,
    ItemTypeWithNavigation = 1 << 1,
    ItemTypeWithAddtion = 1 << 2,
} ProfileItemType;

typedef struct ProfileItem {
    NSString *icon;
    NSString *text;
    NSString *addtionText;
    ProfileItemType type;
} ProfileItem;

@interface UserProfileModel : NSObject

@property(nonatomic, strong) NSMutableArray *profileInfoArray;

- (ProfileItem)readProfileItemWithSection:(NSInteger)section Item:(NSInteger)item;

@end

#endif /* UserProfileModel_h */
