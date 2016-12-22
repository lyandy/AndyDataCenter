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
 *
 * @param primaryKey Primary key value of the model object that you want to fetch.
 *
 * @return Object that match the primary key value, or nil if none is found.
 *
 */

+ (instancetype)andy_db_objectForId:(id)primaryKey;

/**
 *
 * @param where Where clause of SQL. Use '?'s as placeholders for arguments.
 *
 * @param arguments Values to bind to the where clause.
 *
 * @return Objects that match the condition of the where clause.
 *
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
- (void)andy_db_saveArrayObjects;

- (void)andy_db_deleteObject;

/**
 *
 * @param where Where clause of SQL. Use '?'s as placeholders for arguments.
 *
 * @param arguments Values to bind to the where clause.
 *
 */

+ (void)andy_db_deleteObjectsWhere:(NSString *)where arguments:(NSArray *)arguments;

/**
 *
 * @param set Property and new value pairs.
 *
 */

- (instancetype)andy_db_updateObjectSet:(NSDictionary *)set;

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


@end

