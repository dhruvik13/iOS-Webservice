//
//  AppCacheManagement.m
//  iOS_APIParser
//
//  Created by Dhruvik Rao on 9/7/18.
//  Copyright © 2018 Dhruvik Rao. All rights reserved.
//

#import "AppCacheManagement.h"

static BOOL APILoggingEnabled;

@implementation AppCacheManagement

#pragma mark Singleton Methods

+ (id)sharedCacheManager {
	static AppCacheManagement *sharedCacheManager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedCacheManager = [[self alloc] init];
	});
	return sharedCacheManager;
}


#pragma mark - Enable / Disable API Logger

- (BOOL)APILoggingEnabled {
	return APILoggingEnabled;
}

- (void)setAPILoggingEnabled:(BOOL)value {
	APILoggingEnabled = value;
}

#pragma mark - Cache Saving mechanisam

- (void)setCacheToUserDefaults:(NSMutableArray *)resPonseArrayList ForKey:(NSString *)strKey
{
	@autoreleasepool
	{
		[self setCustomObject:resPonseArrayList forKey:strKey];
		resPonseArrayList = nil;
	}
}

- (void)getcachedataArrayFor_:(NSString *)strKey
					 myMethod:(cacheArrayGetCompletion) compblock
{
	@autoreleasepool
	{
		NSMutableArray *retrivedCacheData = [[NSMutableArray alloc] init];
		[retrivedCacheData addObjectsFromArray:[self customObjectForKey:strKey]];
		
		compblock(YES, retrivedCacheData);
	}
}

#pragma mark - object
- (void)setObjectCacheToUserDefaults:(id)resPonseObject ForKey:(NSString *)strKey
{
	@autoreleasepool
	{
		[self setCustomObject:resPonseObject forKey:strKey];
		resPonseObject = nil;
	}
}

- (void) getObjectCachedataFor_:(NSString *)strKey
					   myMethod:(cacheObjectGetCompletion) compblock
{
	@autoreleasepool
	{
		id retrivedObject;
		retrivedObject = [self customObjectForKey:strKey];
		
		compblock(YES, retrivedObject);
	}
}

#pragma mark - Remove key

- (void)removeCacheForKey:(NSString *)objectKey
{
	@autoreleasepool
	{
		[[NSUserDefaults standardUserDefaults] removeObjectForKey:objectKey];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
}

#pragma mark - Remove all cache fro Current User
- (void) removeAllAPICachedObjects
{
	[[NSUserDefaults standardUserDefaults] removeObjectForKey:kDeveloperDebugAPILog];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Encode Array of objects or object

- (id)customObjectForKey:(NSString *)key {
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSData *encodedObject = [defaults objectForKey:key];
	id obj = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
	return obj;
}

- (void)setCustomObject:(id)obj forKey:(NSString *)key {
	if ([obj respondsToSelector:@selector(encodeWithCoder:)] == NO) {
		return;
	}
	NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:obj];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:encodedObject forKey:key];
	[defaults synchronize];
}


@end
