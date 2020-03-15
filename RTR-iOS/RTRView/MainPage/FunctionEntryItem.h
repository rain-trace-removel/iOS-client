//
//  FunctionEntryItem.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/15.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainPageFunctionModel.h"

@protocol FunctionEntryItemViewDelegate <NSObject>

- (void)didClickedEntryItemWithModel:(MainPageFunctionModel *)model;

@end

@interface FunctionEntryItem : UIView

@property (nonatomic, weak) id<FunctionEntryItemViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame andModel:(MainPageFunctionModel *)model;

@end
