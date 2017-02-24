//
//  GYModelObjectProtocol.h
//  GYDataCenter
//
//  Created by 佘泽坡 on 6/30/16.
//  Copyright © 2016 佘泽坡. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, GYCacheLevel) {
    GYCacheLevelNoCache,
    GYCacheLevelDefault,
    GYCacheLevelResident
};

@protocol GYModelObjectProtocol <NSObject>

@property (nonatomic, getter=isCacheHit, readonly) BOOL cacheHit;
@property (nonatomic, getter=isFault, readonly) BOOL fault;
@property (nonatomic, getter=isSaving, readonly) BOOL saving;
@property (nonatomic, getter=isDeleted, readonly) BOOL deleted;


/**
 数据库名称
 
 @return 数据库名称
 */
+ (NSString *)andy_db_dbName;

/**
 表名称  必须实现
 
 目前还不支持表名称替换
 
 @return 表名称
 */
+ (NSString *)andy_db_tableName;

/**
 主键名称
 
 可有可无
 @return 主键
 */
+ (NSString *)andy_db_primaryKey;


/**
 告诉数据库那些字段需要持有
 
 @return 数据库持有字段组成的数组
 */
+ (NSArray *)andy_db_persistentProperties;


/**
 Model 到 数据库 实际Column字段的映射，注意大小写。实现类似于 AndyExtension 框架的实现
 
 @return 字段映射表字典
 */
+ (NSDictionary *)andy_db_replacedKeyFromPropertyName;


/**
 数据库位置的全路径, 如果不实现则 数据库位置 位于 NSDocumentDirectory 根目录下。

 @return 数据库位置的全路径
 */
+ (NSString *)andy_db_fullPath;

+ (NSDictionary *)andy_db_propertyTypes;
+ (NSDictionary *)andy_db_propertyClasses;
+ (NSSet *)andy_db_relationshipProperties;

+ (GYCacheLevel)andy_db_cacheLevel;

+ (NSString *)andy_db_fts;

@optional
+ (NSArray *)andy_db_indices;
+ (NSDictionary *)andy_db_defaultValues;

+ (NSString *)andy_db_tokenize;

@end

@protocol GYTransformableProtocol <NSObject>

+ (NSData *)transformedValue:(id)value;
+ (id)reverseTransformedValue:(NSData *)value;

@end

typedef NS_ENUM(NSUInteger, GYPropertyType) {
    GYPropertyTypeUndefined,
    GYPropertyTypeInteger,
    GYPropertyTypeFloat,
    GYPropertyTypeString,
    GYPropertyTypeBoolean,
    GYPropertyTypeDate,
    GYPropertyTypeData,
    GYPropertyTypeTransformable,
    GYPropertyTypeRelationship
};
