//
//  RTRTabBarItem.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/4.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import "RTRTabBarItem.h"
#import "Colours.h"
#import "Masonry/Masonry.h"

@interface RTRTabBarItem()

@property(nonatomic, strong) UIImageView *buttonIcon;
@property(nonatomic, strong) UILabel *buttonLabel;
@property(nonatomic, copy) NSString *tabBarTag;
@property(nonatomic, copy) NSString *tabBarIcon;
@property(nonatomic, assign) NSUInteger tabBarIndex;

@end

@implementation RTRTabBarItem

- (instancetype)initWithFrame:(CGRect)frame tag:(NSString *)tag icon:(NSString *)icon index:(NSUInteger)index {
    self = [super initWithFrame:frame];
    if (self) {
        self.tabBarTag = tag;
        self.tabBarIcon = icon;
        self.tabBarIndex = index;
        [self addTabBarButton:frame tag:tag Icon:icon index:index];
        [self addTapGesture];
    }
    return self;
}

#pragma mark Private

- (void)addTabBarButton:(CGRect)frame tag:(NSString *)tag Icon:(NSString *)icon index:(NSUInteger)index {
    
    // 计算位置与大小
    CGFloat tabBarItemHeight = frame.size.height;
    CGFloat tabBarItemWidth = frame.size.width;
    CGFloat iconWidth = 32;
    CGFloat iconHeight = 32;
    CGFloat iconX = (tabBarItemWidth - iconWidth)/2;
    CGFloat iconY = (tabBarItemHeight - iconHeight)/4;
    
    // tabbar图标
    self.buttonIcon = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconWidth, iconHeight)];
    [self.buttonIcon setImage:[[UIImage imageNamed:icon] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    [self addSubview:self.buttonIcon];
    
    // tabbar文字
    self.buttonLabel = [[UILabel alloc] init];
    [self.buttonLabel setText:tag];
    [self.buttonLabel setFont:[UIFont systemFontOfSize:13]];
    [self addSubview:self.buttonLabel];
    
    [self.buttonLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.buttonIcon.mas_bottom).offset(1);
        make.height.mas_equalTo(@20);
    }];
    [self.buttonLabel sizeToFit];
    
    [self setSelected:NO];
}

- (void)addTapGesture {
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)tapEvent:(UITapGestureRecognizer *)gesture {
    NSLog(@"tapEvent: %@", self.tabBarTag);
    // todo:添加震动反馈
    
    // todo:添加点击动画
    
    // RTRTabBarItemDelegate
    if ([_delegate respondsToSelector:@selector(didSelectedTabBarItemAtIndex:WithTag:)]) {
        [_delegate didSelectedTabBarItemAtIndex:self.tabBarIndex WithTag:self.tabBarTag ];
    }
    
}

- (void)setSelected:(BOOL)isSelected {
    if (isSelected) {
        [self.buttonIcon setTintColor:[UIColor infoBlueColor]];
        [self.buttonLabel setTextColor:[UIColor infoBlueColor]];
    } else {
        [self.buttonIcon setTintColor:[UIColor black75PercentColor]];
        [self.buttonLabel setTextColor:[UIColor black75PercentColor]];
    }
}




@end
