//
//  UserProfileTableViewHeaderCell.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/15.
//  Copyright © 2020 chenbb6. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UserProfileModel.h"

#ifndef UserProfileTableViewHeaderCell_h
#define UserProfileTableViewHeaderCell_h


@interface UserProfileTableViewHeaderCell : UIView

- (void)reloadViewWithTitle:(NSString *)title;

@end

#endif /* UserProfileTableViewHeaderCell_h */
