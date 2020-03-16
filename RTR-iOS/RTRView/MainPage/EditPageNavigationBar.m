//
//  EditPageNavigationBar.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/16.
//  Copyright © 2020 chenbb6. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "EditPageNavigationBar.h"
#import "RTRDefine.h"
#import "Masonry/Masonry.h"
#import "RLog.h"

@interface EditPageNavigationBar ()
{
    CGFloat margin_hor;
    CGSize icon_size;
}

@property(nonatomic, strong) UIButton *backButton;
@property(nonatomic, strong) UIButton *preStepButton;
@property(nonatomic, strong) UIButton *nextStepButton;
@property(nonatomic, strong) UIButton *saveButton;

@end

@implementation EditPageNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.backButton];
        [self addSubview:self.preStepButton];
        [self addSubview:self.nextStepButton];
        [self addSubview:self.saveButton];
        margin_hor = 20;
        icon_size = CGSizeMake(16, 16);
        [self reloadView];
    }
    return self;
}

- (void)reloadView {
    [self.backButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(margin_hor);
        make.size.mas_equalTo(icon_size);
    }];
    
    [self.preStepButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_centerX).offset(-margin_hor/2);
        make.size.mas_equalTo(icon_size);
    }];
    
    [self.nextStepButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_centerX).offset(margin_hor/2);
        make.size.mas_equalTo(icon_size);
    }];
    
    [self.saveButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-margin_hor);
        make.size.mas_equalTo(icon_size);
    }];
    
//    [self.layer setCornerRadius:self.frame.size.width/10];
//    [self setBackgroundColor:RTRColorFromRGB(0xFCFCFC)];
//
//    [self.backgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self);
//        make.size.equalTo(self);
//    }];
//    [self.backgroundView.layer setCornerRadius:self.frame.size.width/10];
//    [self.backgroundView setBackgroundColor:[UIColor whiteColor]];
//
//    [self.entryImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self);
//        make.top.equalTo(self).offset(10);
//        make.size.mas_equalTo(CGSizeMake(self.frame.size.width/2, self.frame.size.width/2));
//    }];
//    [self.entryImageView.layer setCornerRadius:self.frame.size.width/2/10];
//
//    [self.entryNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.entryImageView.mas_bottom).offset(10);
//        make.centerX.equalTo(self);
//        make.height.mas_equalTo(20);
//    }];
//    [self.entryNameLabel sizeToFit];

}

//- (void)imageViewTapped:(UITapGestureRecognizer *)tap {
//    if ([_delegate respondsToSelector:@selector(didClickedEntryItemWithModel:)]) {
//        [_delegate didClickedEntryItemWithModel:self.model];
//    }
//}

#pragma mark Sender

- (void)backButtonClicked:(id)sender {
    if ([_delegate respondsToSelector:@selector(didClickBackButton)]) {
        [_delegate didClickBackButton];
    }
}

- (void)preStepButtonClicked:(id)sender {
    if ([_delegate respondsToSelector:@selector(didClickPreStepButton)]) {
        [_delegate didClickPreStepButton];
    }
}

- (void)nextStepButtonClicked:(id)sender {
    if ([_delegate respondsToSelector:@selector(didClickNextStepButton)]) {
        [_delegate didClickNextStepButton];
    }
}

- (void)saveButtonClicked:(id)sender {
    if ([_delegate respondsToSelector:@selector(didClickSaveButton)]) {
        [_delegate didClickSaveButton];
    }
}

#pragma mark Getter & Setter

- (UIButton *)backButton {
    if (_backButton == nil) {
        _backButton = [[UIButton alloc] init];
        [_backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_backButton setImage:[UIImage imageNamed:@"editpagebar-back"] forState:UIControlStateNormal];
    }
    return _backButton;
}

- (UIButton *)nextStepButton {
    if (_nextStepButton == nil) {
        _nextStepButton = [[UIButton alloc] init];
        [_nextStepButton addTarget:self action:@selector(nextStepButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_nextStepButton setImage:[UIImage imageNamed:@"editpagebar-nextstep"] forState:UIControlStateNormal];
    }
    return _nextStepButton;
}

- (UIButton *)preStepButton {
    if (_preStepButton == nil) {
        _preStepButton = [[UIButton alloc] init];
        [_preStepButton addTarget:self action:@selector(preStepButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_preStepButton setImage:[UIImage imageNamed:@"editpagebar-prestep"] forState:UIControlStateNormal];
    }
    return _preStepButton;
}

- (UIButton *)saveButton {
    if (_saveButton == nil) {
        _saveButton = [[UIButton alloc] init];
        [_saveButton addTarget:self action:@selector(saveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_saveButton setImage:[UIImage imageNamed:@"editpagebar-save"] forState:UIControlStateNormal];
    }
    return _saveButton;
}

@end

