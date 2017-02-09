//
//  Toys.m
//  AndyDataCenter_Test
//
//  Created by 李扬 on 2016/12/21.
//  Copyright © 2016年 andyshare. All rights reserved.
//

#import "Toy.h"
#import "AndyDataCenter.h"

@implementation Toy

+ (NSString *)andy_db_dbName {
    return @"AndyDataCenter";
}

+ (NSString *)andy_db_tableName {
    return @"Toy";
}

+ (NSString *)andy_db_primaryKey {
    return @"no";
}

+ (NSDictionary *)andy_db_replacedKeyFromPropertyName
{
    return @{@"toyName" : @"name"};
}

+ (NSArray *)andy_db_persistentProperties {
    static NSArray *properties = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        properties = @[
                       @"no",
                       @"toyName",
                       @"price",
                       @"parentId"
                       ];
    });
    return properties;
}


@end
