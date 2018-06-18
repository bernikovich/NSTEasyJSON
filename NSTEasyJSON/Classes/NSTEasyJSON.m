//
//  NSTEasyJSON.m
//  NSTEasyJSON
//
//  Created by Timur Bernikowich on 12/15/16.
//  Copyright © 2016 Timur Bernikovich. All rights reserved.
//

#import "NSTEasyJSON.h"

@interface NSTEasyJSONEmptyObject : NSObject

@end

@implementation NSTEasyJSONEmptyObject

@end

@interface NSTEasyJSON ()

@property (nonatomic) id object;
@property (nonatomic) id currentObject;

@end

@implementation NSTEasyJSON

+ (nonnull instancetype)withObject:(nullable id <NSCopying>)object
{
    NSTEasyJSON *JSON = [self new];
    JSON.object = object;
    return JSON;
}

+ (nonnull instancetype)withData:(nullable NSData *)data
{
    NSError *error;
    NSData *objectData = data ?: [NSData new];
    id object = [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingAllowFragments error:&error];
    return [self withObject:object];
}

- (nonnull instancetype)childWithChildObject:(id)childObject
{
    NSTEasyJSON *JSON = [self.class withObject:self.object];
    JSON.currentObject = childObject;
    return JSON;
}

- (nonnull instancetype)objectForKeyedSubscript:(nonnull id)key
{
    id object;
    if ([key isKindOfClass:NSString.class] && [self.currentObject isKindOfClass:NSDictionary.class]) {
        object = self.currentObject[key];
    }
    
    if (!object) {
        object = [NSTEasyJSONEmptyObject new];
    }
    
    NSTEasyJSON *child = [self childWithChildObject:object];
    return child;
}

- (nonnull instancetype)objectAtIndexedSubscript:(NSUInteger)index
{
    id object;
    if ([self.currentObject isKindOfClass:NSArray.class]) {
        object = self.currentObject[index];
    }
    
    if (!object) {
        object = [NSTEasyJSONEmptyObject new];
    }
    
    NSTEasyJSON *child = [self childWithChildObject:object];
    return child;
}

#pragma mark - Objects

- (nullable id)currentObject
{
    return _currentObject ?: _object;
}

- (nullable id)object
{
    return self.currentObject;
}

#pragma mark - Description

- (NSString *)debugDescription
{
    NSString *className;
    Class currentObjectClass = [self.currentObject class];
    if (currentObjectClass != NULL) {
        className = NSStringFromClass(currentObjectClass);
    }
    
    NSString *objectDescription;
    if (className) {
        objectDescription = [NSString stringWithFormat:@"%@ : %@", className, self.currentObject];
    } else {
        objectDescription = [NSString stringWithFormat:@"%@", self.currentObject];
    }
    
    return [NSString stringWithFormat:@"%@ - %@", [super debugDescription], objectDescription];
}

#pragma mark - Existence

- (BOOL)exists
{
    return (self.currentObject && ![self.currentObject isKindOfClass:NSTEasyJSONEmptyObject.class]);
}

#pragma mark - Values: Special

- (nullable NSArray<NSTEasyJSON *> *)JSONArray
{
    NSArray *array = self.array;
    if (!array.count) {
        return nil;
    }
    
    NSMutableArray<NSTEasyJSON *> *JSONArray = [NSMutableArray new];
    for (id<NSCopying> object in array) {
        // Maybe we need to check if object conforms to NSCopying protocol.
        [JSONArray addObject:[NSTEasyJSON withObject:object]];
    }
    
    return JSONArray;
}

#pragma mark - Values: Objects

- (nullable NSDictionary *)dictionary
{
    if ([self.currentObject isKindOfClass:NSDictionary.class]) {
        return self.currentObject;
    }
    
    return nil;
}

- (nonnull NSDictionary *)dictionaryValue
{
    if ([self.currentObject isKindOfClass:NSDictionary.class]) {
        return self.currentObject;
    }
    
    return @{};
}

- (nullable NSArray *)array
{
    if ([self.currentObject isKindOfClass:NSArray.class]) {
        return self.currentObject;
    }
    
    return nil;
}

- (nonnull NSArray *)arrayValue
{
    if ([self.currentObject isKindOfClass:NSArray.class]) {
        return self.currentObject;
    }
    
    return @[];
}

- (nullable NSString *)string
{
    if ([self.currentObject isKindOfClass:NSString.class]) {
        return self.currentObject;
    }
    
    return nil;
}

- (nonnull NSString *)stringValue
{
    if ([self.currentObject isKindOfClass:NSString.class]) {
        return self.currentObject;
    }
    
    return @"";
}

- (nonnull NSString *)jsonStringValue
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_currentObject options:0 error:&error];
    
    if (jsonData) {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return @"";
}

- (nullable NSString *)forceToString
{
    if ([self.currentObject isKindOfClass:NSString.class]) {
        return self.stringValue;
    }
    
    if ([self.currentObject isKindOfClass:NSNumber.class]) {
        return [NSString stringWithFormat:@"%@", self.numberValue];
    }
    
    if ([self.currentObject isKindOfClass:NSDictionary.class]) {
        return self.jsonStringValue;
    }
    
    if ([self.currentObject isKindOfClass:NSArray.class]) {
        return self.jsonStringValue;
    }
    
    return nil;
}

- (nonnull NSString *)forceToStringValue
{
    if ([self.currentObject isKindOfClass:NSString.class]) {
        return self.stringValue;
    }
    
    if ([self.currentObject isKindOfClass:NSNumber.class]) {
        return [NSString stringWithFormat:@"%@", self.numberValue];
    }
    
    if ([self.currentObject isKindOfClass:NSDictionary.class]) {
        return self.jsonStringValue;
    }
    
    if ([self.currentObject isKindOfClass:NSArray.class]) {
        return self.jsonStringValue;
    }
    
    return @"";
}

- (nullable NSURL *)URL
{
    if ([self.currentObject isKindOfClass:NSString.class]) {
        NSURL *URL = [NSURL URLWithString:self.currentObject];
        return URL;
    }
    
    return nil;
}

- (nullable NSNumber *)number
{
    if ([self.currentObject isKindOfClass:NSNumber.class]) {
        return self.currentObject;
    }
    
    return nil;
}

- (nonnull NSNumber *)numberValue
{
    if ([self.currentObject isKindOfClass:NSNumber.class]) {
        return self.currentObject;
    }
    
    return @(0);
}

#pragma mark - Values: Primitives

- (NSInteger)integerValue
{
    return self.numberValue.integerValue;
}

- (NSUInteger)unsignedIntegerValue
{
    return self.numberValue.unsignedIntegerValue;
}

- (BOOL)boolValue
{
    return self.numberValue.boolValue;
}

- (double)doubleValue
{
    return self.numberValue.doubleValue;
}

- (float)floatValue
{
    return self.numberValue.floatValue;
}

@end
