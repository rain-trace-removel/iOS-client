//
//  UserProfileTableViewCell.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/15.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfileTableViewCell.h"
#import "RTRDefine.h"
#import "Masonry/Masonry.h"

@interface UserProfileTableViewCell()

@property(nonatomic, strong) UIImageView *iconView;
@property(nonatomic, strong) UILabel *titleContent;
@property(nonatomic, strong) UILabel *addtionTitle;
@property(nonatomic, strong) UIImageView *navigationIcon;

@end

@implementation UserProfileTableViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.iconView];
        [self addSubview:self.titleContent];
        [self addSubview:self.addtionTitle];
        [self addSubview:self.navigationIcon];
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self.iconView setImage:[UIImage imageNamed:@"icon_app"]];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(20);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
    
    [self.titleContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(20);
        make.centerY.equalTo(self.iconView);
        make.height.mas_equalTo(30);
    }];
    [self.titleContent sizeToFit];
    
    [self.navigationIcon setImage:[UIImage imageNamed:@"icon_right_arrow"]];
    [self.navigationIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    [self.addtionTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navigationIcon.mas_left).offset(-20);
        make.centerY.equalTo(self.navigationIcon);
        make.height.mas_equalTo(30);
    }];
}

- (void)reloadViewWithProfileItem:(ProfileItem)item {
    [self.iconView setImage:[UIImage imageNamed:item.icon]];
    [self.titleContent setText:item.text];
    [self.titleContent sizeToFit];
    [self.addtionTitle setText:item.addtionText];
    [self.addtionTitle sizeToFit];
    
    [self.addtionTitle setHidden: !(item.type & ItemTypeWithAddtion)];
    [self.navigationIcon setHidden:!(item.type & ItemTypeWithNavigation)];
}

#pragma mark Getter & Setter

- (UIImageView *)iconView {
    if (_iconView == nil) {
        _iconView = [UIImageView new];
    }
    return _iconView;
}

- (UILabel *)titleContent {
    if (_titleContent == nil) {
        _titleContent = [[UILabel alloc] init];
        [_titleContent setText:@"标题"];
        [_titleContent setFont:[UIFont systemFontOfSize:23]];
        [_titleContent setTextAlignment:NSTextAlignmentLeft];
        [_titleContent setNumberOfLines: 0];
    }
    return _titleContent;
}

- (UILabel *)addtionTitle {
    if (_addtionTitle == nil) {
        _addtionTitle = [[UILabel alloc] init];
        [_addtionTitle setText:@"更多信息"];
        [_addtionTitle setFont:[UIFont systemFontOfSize:23]];
        [_addtionTitle setTextAlignment:NSTextAlignmentLeft];
        [_addtionTitle setNumberOfLines: 0];
    }
    return _addtionTitle;
}
                                      
- (UIImageView *)navigationIcon {
    if (_navigationIcon == nil) {
        _navigationIcon = [UIImageView new];
    }
    return _navigationIcon;
}

@end
