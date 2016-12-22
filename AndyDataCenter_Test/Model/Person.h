//
//  Person.h
//  AndyDataCenter_Test
//
//  Created by 李扬 on 2016/12/20.
//  Copyright © 2016年 andyshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Toy.h"

@interface Person : NSObject

@property (nonatomic, copy) NSString *Id;

@property (nonatomic, copy) NSString *parentId;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, strong) Toy *toy;

@end
