//
//  NSObject+DataCenter.h
//  AndyDataCenter_Test
//
//  Created by 李扬 on 2016/12/20.
//  Copyright © 2016年 andyshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GYModelObjectProtocol.h"

@interface NSObject (DataCenter)<GYModelObjectProtocol, NSCopying>

/**
 根据主键查询数据Model。注意 参数 表字段名称或Model属性名称 大小写

 @param primaryKey 主键
 @return 返回查询到的Model
 */
+ (instancetype)andy_db_objectForId:(id)primaryKey;

/**
 根据条件查询到数据Model组成的数组。注意 参数 表字段名称或Model属性名称 大小写

 @param where 查询条件
 @param arguments 查询参数
 @return 返回查询到的Model组成的数组
 */
+ (NSArray *)andy_db_objectsWhere:(NSString *)where arguments:(NSArray *)arguments;

/**
 *
 * @param where Where clause of SQL. Use '?'s as placeholders for arguments.
 *
 * @param arguments Values to bind to the where clause.
 *
 * @return Primary key values that match the condition of the where clause.
 *
 */

+ (NSArray *)andy_db_idsWhere:(NSString *)where arguments:(NSArray *)arguments;

/**
 *
 * @param function Aggregate function. For example: 'count(*)', 'sum(value)'...
 *
 * @param where Where clause of SQL. Use '?'s as placeholders for arguments.
 *
 * @param arguments Values to bind to the where clause.
 *
 * @return Result of the aggregate function.
 *
 */

+ (NSNumber *)andy_db_aggregate:(NSString *)function where:(NSString *)where arguments:(NSArray *)arguments;

- (void)andy_db_saveObject;
- (void)andy_db_saveObjectSuccess:(void (^)())success failure:(void (^)(id error))failure;

- (void)andy_db_saveArrayObjects;
- (void)andy_db_saveArrayObjectsSuccess:(void (^)())success failure:(void (^)(id error))failure;

- (void)andy_db_deleteObject;
- (void)andy_db_deleteObjectSuccess:(void (^)())success failure:(void (^)(id error))failure;

/**
 *
 * @param where Where clause of SQL. Use '?'s as placeholders for arguments.
 *
 * @param arguments Values to bind to the where clause.
 *
 */

+ (void)andy_db_deleteObjectsWhere:(NSString *)where arguments:(NSArray *)arguments;
+ (void)andy_db_deleteObjectsWhere:(NSString *)where arguments:(NSArray *)arguments success:(void (^)())success failure:(void (^)(id error))failure;

/**
 *
 * @param set Property and new value pairs.
 *
 */

- (instancetype)andy_db_updateObjectSet:(NSDictionary *)set;
- (instancetype)andy_db_updateObjectSet:(NSDictionary *)set success:(void (^)())success failure:(void (^)(id error))failure;

/**
 *
 * @param set Property and new value pairs.
 *
 * @param where Where clause of SQL. Use '?'s as placeholders for arguments.
 *
 * @param arguments Values to bind to the where clause.
 *
 */

+ (void)andy_db_updateObjectsSet:(NSDictionary *)set Where:(NSString *)where arguments:(NSArray *)arguments;
+ (void)andy_db_updateObjectsSet:(NSDictionary *)set Where:(NSString *)where arguments:(NSArray *)arguments success:(void (^)())success failure:(void (^)(id error))failure;


@end

