//
//  UserProfileTableViewHeaderCell.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/15.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfileTableViewHeaderCell.h"
#import "Masonry/Masonry.h"

@interface UserProfileTableViewHeaderCell()

@property(nonatomic, strong) UILabel *title;

@end

@implementation UserProfileTableViewHeaderCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.title];
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.centerY.equalTo(self);
        make.height.equalTo(self);
    }];
    [self.title sizeToFit];
}

- (void)reloadViewWithTitle:(NSString *)title {
    [self.title setText:title];
    [self.title sizeToFit];
}

- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc] init];
        [_title setText:@"通用"];
        [_title setFont:[UIFont systemFontOfSize:30]];
        [_title setTextAlignment:NSTextAlignmentLeft];
        [_title setNumberOfLines: 0];
    }
    return _title;
}

@end
