//
//  Road.m
//  AndyDataCenter_Test
//
//  Created by 李扬 on 2016/12/21.
//  Copyright © 2016年 andyshare. All rights reserved.
//
#import "Road.h"
#import "AndyDataCenter.h"

@implementation Road


/**
 数据库名称

 @return 数据库名称
 */
+ (NSString *)andy_db_dbName {
    return @"AndyDataCenter";
}

/**
 表名称  必须实现

 目前还不支持表名称替换
 
 @return 表名称
 */
+ (NSString *)andy_db_tableName {
    return @"Road";
}

/**
 主键名称
 
 可有可无
 @return 主键
 */
+ (NSString *)andy_db_primaryKey {
    return @"Id";
}


/**
 Model 到 数据库 实际Column字段的映射，注意大小写。实现类似于 AndyExtension 框架的实现

 @return 字段映射表字典
 */
+ (NSDictionary *)andy_db_replacedKeyFromPropertyName
{
    return @{@"Id" : @"id", @"name" : @"address", @"provin" : @"province"};
}


/**
 告诉数据库那些字段需要持有

 @return 数据库持有字段组成的数组
 */
+ (NSArray *)andy_db_persistentProperties {
    static NSArray *properties = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        properties = @[
                       @"Id",
                       @"no",
                       @"name",
                       @"provin"
                       ];
    });
    return properties;
}


@end
