//
//  UserProfileView.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/14.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfileView.h"
#import "RTRUserManager.h"
#import "UserProfileTableViewCell.h"
#import "RLog.h"
#import "UserProfileTableViewHeaderCell.h"

@interface UserProfileView() <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *profileTableView;
@property(nonatomic, strong) NSString *identifier;

@end


@implementation UserProfileView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        self.identifier = [NSString stringWithFormat:@"%s", __FILE__];
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self setBackgroundColor:[UIColor yellowColor]];
    [self addSubview:self.profileTableView];
}

- (UITableView *)profileTableView {
    if(_profileTableView == nil) {
        _profileTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStyleGrouped];
        [_profileTableView setBackgroundColor:[UIColor whiteColor]];
        _profileTableView.delegate = self;
        _profileTableView.dataSource = self;
        _profileTableView.showsVerticalScrollIndicator = NO;
        _profileTableView.separatorStyle = UITableViewCellAccessoryNone;

    }
    return _profileTableView;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[RTRUserManager rtr_shareManager].userProfile.profileInfoArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[RTRUserManager rtr_shareManager].userProfile.profileInfoArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = [NSString stringWithFormat:@"%@-%zd-%zd", self.identifier, indexPath.section, indexPath.row];
    UITableViewCell * cell  = [tableView dequeueReusableCellWithIdentifier: cellID];
    [cell setBackgroundColor:[UIColor whiteColor]];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: cellID];
    }
    [cell setSelectionStyle: UITableViewCellSelectionStyleNone];
    for(UIView *view in cell.subviews){
        [view removeFromSuperview];
    }
    
    // 通用设置页
    UserProfileTableViewCell *cell_view = [[UserProfileTableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 80)];
    [cell_view reloadViewWithProfileItem:[[RTRUserManager rtr_shareManager].userProfile readProfileItemWithSection:indexPath.section Item:indexPath.item]];
    [cell addSubview:cell_view];
    return cell;
}



#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    rtr_log(indexPath);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UserProfileTableViewHeaderCell *headerCell = [[UserProfileTableViewHeaderCell alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100)];
    [headerCell reloadViewWithTitle:(section == 0) ? @"通用" : @"关于Keepic"];
    return headerCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}



@end
