//
//  RLog.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/14.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#ifndef RLog_h
#define RLog_h

#define rtr_log(obj) NSLog(@"\n[FILE]: %s\n[FUNCTION]:%s\n[LINE]:%d\n[cbb]%@\n", __FILE__, __FUNCTION__, __LINE__, obj);

@interface RLog : NSObject

@end

#endif /* RLog_h */
