//
//  EditPageNavigationBar.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/16.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditPageNavigationBarDelegate <NSObject>

- (void)didClickBackButton;
- (void)didClickPreStepButton;
- (void)didClickNextStepButton;
- (void)didClickSaveButton;

@end

@interface EditPageNavigationBar : UIView

@property (nonatomic, weak) id<EditPageNavigationBarDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame;

@end
