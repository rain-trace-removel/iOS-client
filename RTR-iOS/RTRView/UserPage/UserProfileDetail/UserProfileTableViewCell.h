//
//  UserProfileTableViewCell.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/15.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfileModel.h"

#ifndef UserProfileTableViewCell_h
#define UserProfileTableViewCell_h


@interface UserProfileTableViewCell : UIView

- (void)reloadViewWithProfileItem: (ProfileItem)item;

@end

#endif /* UserProfileTableViewCell_h */
