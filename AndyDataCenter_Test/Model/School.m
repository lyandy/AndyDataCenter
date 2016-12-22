//
//  School.m
//  AndyDataCenter_Test
//
//  Created by 李扬 on 2016/12/21.
//  Copyright © 2016年 andyshare. All rights reserved.
//

#import "School.h"
#import "AndyDataCenter.h"

@implementation School

+ (NSString *)andy_db_dbName {
    return @"AndyDataCenter";
}

+ (NSString *)andy_db_tableName {
    return @"School";
}

+ (NSString *)andy_db_primaryKey {
    return @"Id";
}

+ (NSArray *)andy_db_persistentProperties {
    static NSArray *properties = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        properties = @[
                       @"Id",
                       @"name"
                       ];
    });
    return properties;
}


@end
