//
//  Person.m
//  AndyDataCenter_Test
//
//  Created by 李扬 on 2016/12/20.
//  Copyright © 2016年 andyshare. All rights reserved.
//

#import "Person.h"
#import "AndyDataCenter.h"

@implementation Person

+ (NSString *)andy_db_dbName {
    return @"AndyDataCenter";
}

+ (NSString *)andy_db_tableName {
    return @"Person";
}

+ (NSString *)andy_db_primaryKey {
    return @"Id";
}

+ (NSDictionary *)andy_db_replacedKeyFromPropertyName
{
    return @{@"Id" : @"pId", @"name" : @"nickName", @"age" : @"myAge"};
}

+ (NSArray *)andy_db_persistentProperties {
    static NSArray *properties = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        properties = @[
                       @"Id",
                       @"name",
                       @"age",
                       @"parentId"
                       ];
    });
    return properties;
}

@end
