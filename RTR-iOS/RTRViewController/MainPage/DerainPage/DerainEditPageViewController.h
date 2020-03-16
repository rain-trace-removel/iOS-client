//
//  DerainEditPageViewController.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/16.
//  Copyright © 2020 chenbb6. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "DerainEditPageViewModel.h"

@interface DerainEditPageViewController : UIViewController

- (void)reloadViewWithModel:(DerainEditPageViewModel *)model;

@end
