//
//  RTRTabBarItem.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/4.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RTRTabBarItemDelegate <NSObject>

@required
- (void)didSelectedTabBarItemAtIndex:(NSUInteger)index WithTag:(NSString *)tag;

@end

@interface RTRTabBarItem : UIView

@property (nonatomic, weak) id<RTRTabBarItemDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame tag:(NSString *)tag icon:(NSString *)icon index:(NSUInteger)index;

- (void)setSelected:(BOOL)isSelected;

@end
