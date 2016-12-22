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

+ (NSString *)andy_db_dbName;
+ (NSString *)andy_db_tableName;
+ (NSString *)andy_db_primaryKey;
+ (NSArray *)andy_db_persistentProperties;

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
