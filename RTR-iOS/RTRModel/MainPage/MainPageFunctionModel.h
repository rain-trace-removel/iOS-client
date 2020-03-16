//
//  MainPageFunctionModel.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/15.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#ifndef MainPageFunctionModel_h
#define MainPageFunctionModel_h

typedef enum NSUInteger {
    TypeCameraPhoto     = 1,
    TypePictureEdit     = 1<<1,
    TypeVideoEdit       = 1<<2,
    TypePictureDerain   = 1<<3,
    TypePictureBorder   = 1<<4,
    TypeUserVIPService  = 1<<5
}FunctionModelType;

@interface MainPageFunctionModel : NSObject

@property(nonatomic, assign) NSString *icon;
@property(nonatomic, assign) NSString *title;
@property(nonatomic, assign) FunctionModelType type;

- (instancetype)initWithIcon:(NSString *)icon Title:(NSString *)title Type:(FunctionModelType)type;

@end

#endif /* MainPageFunctionModel_h */
