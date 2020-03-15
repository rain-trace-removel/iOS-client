//
//  FunctionEntryItem.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/15.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FunctionEntryItem.h"
#import "RTRDefine.h"
#import "Masonry/Masonry.h"

@interface FunctionEntryItem ()

@property(nonatomic, strong) MainPageFunctionModel *model;
@property(nonatomic, strong) UIImageView *backgroundView;
@property(nonatomic, strong) UIImageView *entryImageView;
@property(nonatomic, strong) UILabel *entryNameLabel;

@end

@implementation FunctionEntryItem

- (instancetype)initWithFrame:(CGRect)frame andModel:(MainPageFunctionModel *)model
{
    self = [super initWithFrame:frame];
    if (self) {
        self.model = model;
        [self addSubview:self.backgroundView];
        [self addSubview:self.entryImageView];
        [self addSubview:self.entryNameLabel];
        [self reloadView];
    }
    return self;
}

- (void)reloadView {
    [self.layer setCornerRadius:self.frame.size.width/10];
    [self setBackgroundColor:RTRColorFromRGB(0xFCFCFC)];
    
    [self.backgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.equalTo(self);
    }];
    [self.backgroundView.layer setCornerRadius:self.frame.size.width/10];
    [self.backgroundView setBackgroundColor:[UIColor whiteColor]];
    
    [self.entryImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width/2, self.frame.size.width/2));
    }];
    [self.entryImageView setImage:[UIImage imageNamed:self.model.icon]];
    [self.entryImageView.layer setCornerRadius:self.frame.size.width/2/10];
    
    [self.entryNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.entryImageView.mas_bottom).offset(10);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(20);
    }];
    [self.entryNameLabel setText:self.model.title];
    [self.entryNameLabel sizeToFit];

}

- (UIImageView *)backgroundView {
    if (_backgroundView == nil) {
        _backgroundView = [UIImageView new];
        [_backgroundView setAlpha:0.1];
    }
    return _backgroundView;
}

- (UIImageView *)entryImageView {
    if (_entryImageView == nil) {
        _entryImageView = [UIImageView new];
    }
    return _entryImageView;
}

- (UILabel *)entryNameLabel {
    if (_entryNameLabel == nil) {
        _entryNameLabel = [UILabel new];
        [_entryNameLabel setText:@"名字"];
        [_entryNameLabel setTextColor:[UIColor lightGrayColor]];
        [_entryNameLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [_entryNameLabel setTextAlignment:NSTextAlignmentLeft];
        [_entryNameLabel setNumberOfLines: 0];
    }
    return _entryNameLabel;
}

@end
