//
//  NSObject+DataCenter.m
//  AndyDataCenter_Test
//
//  Created by 李扬 on 2016/12/20.
//  Copyright © 2016年 andyshare. All rights reserved.
//

#import "NSObject+DataCenter.h"

#import "GYDataContext.h"
#import "GYDCUtilities.h"
#import "GYReflection.h"
#import <objc/runtime.h>

@implementation NSObject (DataCenter)

//@dynamic cacheHit;
//@dynamic fault;
//@dynamic saving;
//@dynamic deleted;

//@dynamic cacheHit;
- (void)setCacheHit:(BOOL)cacheHit
{
    // 添加属性,跟对象
    // 给某个对象产生关联,添加属性
    // object:给哪个对象添加属性
    // key:属性名,根据key去获取关联的对象 ,void * == id
    // value:关联的值
    // policy:策略
    objc_setAssociatedObject(self, @"cacheHit", @(cacheHit), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isCacheHit
{
    return [(NSNumber *)objc_getAssociatedObject(self, @"cacheHit") boolValue];
}

//@dynamic fault;
- (void)setFault:(BOOL)fault
{
    objc_setAssociatedObject(self, @"fault", @(fault), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isFault
{
    return [(NSNumber *)objc_getAssociatedObject(self, @"fault") boolValue];
}

//@dynamic saving;
- (void)setSaving:(BOOL)saving
{
    objc_setAssociatedObject(self, @"saving", @(saving), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isSaving
{
    return [(NSNumber *)objc_getAssociatedObject(self, @"saving") boolValue];
}

//@dynamic deleted;
- (void)setDeleted:(BOOL)deleted
{
    objc_setAssociatedObject(self, @"deleted", @(deleted), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isDeleted
{
    return [(NSNumber *)objc_getAssociatedObject(self, @"deleted") boolValue];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    Class modelClass = [self class];
    NSObject *object = [[modelClass alloc] init];
    
    NSArray *persistentProperties = [modelClass andy_db_persistentProperties];
    for (NSString *property in persistentProperties) {
        [object setValue:[self valueForKey:property] forKey:property];
    }
    
    return object;
}

#pragma mark - GYModelObjectProtocol

+ (NSString *)andy_db_dbName {
    NSAssert(NO, @"%s : Should implement method in original class", __func__);
    return nil;
}

+ (NSString *)andy_db_tableName {
    NSAssert(NO, @"%s : Should implement method in original class", __func__);
    return nil;
}

+ (NSString *)andy_db_primaryKey {
    return nil;
}

+ (NSArray *)andy_db_persistentProperties {
    NSAssert(NO, @"%s : Should implement method in original class", __func__);
    return nil;
}

+ (NSDictionary *)andy_db_propertyTypes {
    static const void * const kPropertyTypesKey = &kPropertyTypesKey;
    NSDictionary *result = objc_getAssociatedObject(self, kPropertyTypesKey);
    if (!result) {
        NSArray *properties = [GYDCUtilities persistentPropertiesForClass:self];
        result = [[NSMutableDictionary alloc] initWithCapacity:properties.count];
        for (NSString *property in properties) {
            GYPropertyType type = [GYDCUtilities propertyTypeOfClass:self propertyName:property];
            [(NSMutableDictionary *)result setObject:@(type) forKey:property];
        }
        objc_setAssociatedObject(self, kPropertyTypesKey, result, OBJC_ASSOCIATION_COPY);
    }
    return result;
}

+ (NSDictionary *)andy_db_propertyClasses {
    static const void * const kPropertyClassesKey = &kPropertyClassesKey;
    NSDictionary *result = objc_getAssociatedObject(self, kPropertyClassesKey);
    if (!result) {
        result = [[NSMutableDictionary alloc] init];
        NSDictionary *propertyTypes = [self andy_db_propertyTypes];
        for (NSString *property in propertyTypes.allKeys) {
            GYPropertyType type = [[propertyTypes objectForKey:property] unsignedIntegerValue];
            if (type == GYPropertyTypeRelationship ||
                type == GYPropertyTypeTransformable) {
                NSString *className = [GYReflection propertyTypeOfClass:self propertyName:property];
                Class propertyClass = NSClassFromString(className);
                [(NSMutableDictionary *)result setObject:propertyClass forKey:property];
            }
        }
        objc_setAssociatedObject(self, kPropertyClassesKey, result, OBJC_ASSOCIATION_COPY);
    }
    return result;
}

+ (NSSet *)andy_db_relationshipProperties {
    static const void * const kRelationshipPropertiesKey = &kRelationshipPropertiesKey;
    NSSet *result = objc_getAssociatedObject(self, kRelationshipPropertiesKey);
    if (!result) {
        result = [[NSMutableSet alloc] init];
        NSDictionary *propertyTypes = [self andy_db_propertyTypes];
        for (NSString *property in propertyTypes.allKeys) {
            GYPropertyType type = [[propertyTypes objectForKey:property] unsignedIntegerValue];
            if (type == GYPropertyTypeRelationship) {
                [(NSMutableSet *)result addObject:property];
            }
        }
        objc_setAssociatedObject(self, kRelationshipPropertiesKey, result, OBJC_ASSOCIATION_COPY);
    }
    return result;
}

+ (GYCacheLevel)andy_db_cacheLevel {
    return GYCacheLevelDefault;
}

+ (NSString *)andy_db_fts {
    return nil;
}

#pragma mark - Data Manipulation

+ (instancetype)andy_db_objectForId:(id)primaryKey {
    return [[GYDataContext sharedInstance] getObject:self properties:nil primaryKey:primaryKey];
}

+ (NSArray *)andy_db_objectsWhere:(NSString *)where arguments:(NSArray *)arguments {
    return [[GYDataContext sharedInstance] getObjects:self properties:nil where:where arguments:arguments];
}

+ (NSArray *)andy_db_idsWhere:(NSString *)where arguments:(NSArray *)arguments {
    return [[GYDataContext sharedInstance] getIds:self where:where arguments:arguments];
}

+ (NSNumber *)andy_db_aggregate:(NSString *)function where:(NSString *)where arguments:(NSArray *)arguments {
    return [[GYDataContext sharedInstance] aggregate:self function:function where:where arguments:arguments];
}

- (void)andy_db_saveObject {
    [[GYDataContext sharedInstance] saveObject:self];
}

- (void)andy_db_saveArrayObjects
{
    if ([self isKindOfClass:[NSArray class]] || [self isKindOfClass:[NSMutableArray class]])
    {
        if ([self isKindOfClass:[NSArray class]])
        {
            [((NSArray *)self) enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj andy_db_saveObject];
            }];
        }
        else if ([self isKindOfClass:[NSMutableArray class]])
        {
            NSArray *arr = [((NSMutableArray *)self) copy];
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj andy_db_saveObject];
            }];
        }
    }
    else
    {
        NSAssert(NO, @"%s : should be called by an array", __func__);
    }
}

- (void)andy_db_deleteObject {
    Class<GYModelObjectProtocol> modelClass = [self class];
    [[GYDataContext sharedInstance] deleteObject:modelClass primaryKey:[self valueForKey:[modelClass andy_db_primaryKey]]];
}

+ (void)andy_db_deleteObjectsWhere:(NSString *)where arguments:(NSArray *)arguments {
    [[GYDataContext sharedInstance] deleteObjects:self where:where arguments:arguments];
}

- (instancetype)andy_db_updateObjectSet:(NSDictionary *)set {
    Class<GYModelObjectProtocol> modelClass = [self class];
    return [[GYDataContext sharedInstance] updateAndReturnObject:modelClass set:set primaryKey:[self valueForKey:[modelClass andy_db_primaryKey]]];
}

+ (void)andy_db_updateObjectsSet:(NSDictionary *)set Where:(NSString *)where arguments:(NSArray *)arguments {
    [[GYDataContext sharedInstance] updateObjects:self set:set where:where arguments:arguments];
}


@end
