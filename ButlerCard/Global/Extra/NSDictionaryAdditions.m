//
//  NSDictionaryAdditions.m
//  WeiboPad
//
//  Created by junmin liu on 10-10-6.
//  Copyright 2010 Openlab. All rights reserved.
//

#import "NSDictionaryAdditions.h"


@implementation NSDictionary (Additions)

- (BOOL)getBoolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue {
    return [self objectForKey:key] == [NSNull null] ? defaultValue 
						: [[self objectForKey:key] boolValue];
}

- (int)getIntValueForKey:(NSString *)key defaultValue:(int)defaultValue {
	return [self objectForKey:key] == [NSNull null] 
				? defaultValue : [[self objectForKey:key] intValue];
}

- (time_t)getTimeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue {
	NSString *stringTime   = [self objectForKey:key];
    if ((id)stringTime == [NSNull null]) {
        stringTime = @"";
    }
	struct tm created;
    time_t now;
    time(&now);
    
	if (stringTime) {
		if (strptime([stringTime UTF8String], "%a %b %d %H:%M:%S %z %Y", &created) == NULL) {
			strptime([stringTime UTF8String], "%a, %d %b %Y %H:%M:%S %z", &created);
		}
		return mktime(&created);
	}
	return defaultValue;
}

- (long long)getLongLongValueValueForKey:(NSString *)key defaultValue:(long long)defaultValue {
	return [self objectForKey:key] == [NSNull null] 
		? defaultValue : [[self objectForKey:key] longLongValue];
}

- (double)getDoubleValueValueForKey:(NSString *)key defaultValue:(long long)defaultValue {
	return [self objectForKey:key] == [NSNull null] 
	? defaultValue : [[self objectForKey:key] doubleValue];
}

- (NSString *)getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue{
	return [self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null] 
				? defaultValue : [self objectForKey:key];
}

- (NSArray *)getArrayValueForKey:(NSString *)key{
	return [self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null]
    ? nil : [self objectForKey:key];
}

+ (BOOL)isValidValue:(NSObject*)obj
{
    if(obj == nil)
        return NO;
    
    if(obj == nil || obj == [NSNull null])
        return NO;
    
    return YES;    
}

+ (BOOL)isValidNSDictionary:(NSObject*)obj
{
    if(![self isValidValue:obj])
        return NO;
        
    if(![obj isKindOfClass:[NSDictionary class]])
    {
        return NO;
    }
    
    return YES;
}


@end
