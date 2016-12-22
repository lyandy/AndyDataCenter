//
//  School.h
//  AndyDataCenter_Test
//
//  Created by 李扬 on 2016/12/21.
//  Copyright © 2016年 andyshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface School : NSObject

@property (nonatomic, copy) NSString *Id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray<Person *> *persons;

@end
