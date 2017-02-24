//
//  AndyDataCenterConst.h
//  AndyDataCenter_Test
//
//  Created by 李扬 on 2017/2/24.
//  Copyright © 2017年 andyshare. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ANDYDATACENTER_EXTERN UIKIT_EXTERN

#define AndyDataCenterAssert(condition, desc, ...)  NSAssert(condition, desc, ##__VA_ARGS__)

#define AndyDataCenterDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)
