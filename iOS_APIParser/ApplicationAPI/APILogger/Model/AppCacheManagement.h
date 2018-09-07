//
//  AppCacheManagement.h
//  iOS_APIParser
//
//  Created by Dhruvik Rao on 9/7/18.
//  Copyright © 2018 Dhruvik Rao. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString* kDeveloperDebugAPILog = @"DeveloperDebugAPILog";

static int kConstMaxDebugAPICount = 50;

typedef void(^cacheArrayGetCompletion)(BOOL status, NSMutableArray* retrivedArray);

typedef void(^cacheObjectGetCompletion)(BOOL status, id obj);

@interface AppCacheManagement : NSObject


+ (id)sharedCacheManager;

#pragma mark - Enable / Disable API Logger

- (BOOL)APILoggingEnabled;
- (void)setAPILoggingEnabled:(BOOL)value;


#pragma mark - Cache Saving mechanisam
- (void)setCacheToUserDefaults:(NSMutableArray *)resPonseArrayList ForKey:(NSString *)strKey ;
- (void)getcachedataArrayFor_:(NSString *)strKey myMethod:(cacheArrayGetCompletion) compblock ;
- (void)removeCacheForKey:(NSString *)objectKey ;


#pragma mark - Object
- (void)setObjectCacheToUserDefaults:(id)resPonseObject ForKey:(NSString *)strKey ;
- (void)getObjectCachedataFor_:(NSString *)strKey myMethod:(cacheObjectGetCompletion) compblock;


#pragma mark - Remove all cache fro Current User
- (void) removeAllAPICachedObjects ;

@end
