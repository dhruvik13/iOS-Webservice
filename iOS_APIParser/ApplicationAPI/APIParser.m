//
//  APIParser.m
//  iOS_APIParser
//
//  Created by Dhruvik Rao on 16/11/15.
//  Copyright © 2015 Dhruvik Rao. All rights reserved.
//

#import "APIParser.h"
#import "APIInfoObject.h"
#import "AppCacheManagement.h"

@implementation APIParser

#pragma mark - Properties

@synthesize WSoperationQueue = WSoperationQueue;

#pragma mark - Init NSObject

- (id)init
{
    if ( ( self = [super init] ) )
    {
        // The maxConcurrentOperationCount should reflect the number of open
        // connections the server can handle. Right now, limit it to two for
        // the sake of this example.
        WSoperationQueue = [[NSOperationQueue alloc] init];
        WSoperationQueue.maxConcurrentOperationCount = 16;
        
        if (IOS_NEWER_OR_EQUAL_TO_X(8.0)) {
            
            WSoperationQueue.qualityOfService = NSQualityOfServiceBackground;
        }
        
        // Allocate a reachability object
        Reachability* reach = [Reachability reachabilityWithHostname:@ServerPath];
        
        // Set the blocks
        reach.reachableBlock = ^(Reachability*reach)
        {
            ////TRC_DBG(@"%s REACHABLE!",ServerPath);
        };
        
        reach.unreachableBlock = ^(Reachability*reach)
        {
            ////TRC_DBG(@"%s UNREACHABLE!",ServerPath);
        };
        
        // Start the notifier, which will cause the reachability object to retain itself!
        [reach startNotifier];
        
        [WSoperationQueue addObserver:self forKeyPath:@"operations" options:0 context:NULL];
    }
    return self;
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                         change:(NSDictionary *)change context:(void *)context
{
    APIParser *parser =[APIParser sharedMediaServer];
    
    if (object == parser.WSoperationQueue && [keyPath isEqualToString:@"operations"])
    {
        if ([parser.WSoperationQueue.operations count] == 0)
        {
			runOnMainQueueWithoutDeadlocking(^{
				ShowNetworkIndicator(0);
			});
		}
	}
    else {
        [super observeValueForKeyPath:keyPath ofObject:object
                               change:change context:context];
    }
}

#pragma mark - Cancel all API request with operation

- (void)cancelALLCurrentlyExecutingRequest {
	[WSoperationQueue cancelAllOperations];
	ShowNetworkIndicator(0);
}

#pragma mark - API

+ (id)sharedMediaServer;
{
    static dispatch_once_t onceToken;
    static id sharedMediaServer = nil;
    
    dispatch_once( &onceToken, ^{
        sharedMediaServer = [[[self class] alloc] init];
    });
    
    return sharedMediaServer;
}

- (NSData *) dictionaryWithPropertiesOfObject:(id)obj
{
    NSError *jsonError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithDictionary:(NSMutableDictionary *)obj] options:0 error:&jsonError];
    
    if (jsonError!=nil)
    {
        return nil;
    }
    return jsonData;
}

- (NSData *)dictionaryToJSONData:(NSDictionary *)dict
{
    NSError *jsonError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithDictionary:dict] options:0 error:&jsonError];
    
    if (jsonError!=nil)
    {
        return nil;
    }
    return jsonData;
}

- (NSData *)dictionaryWithmembersOfObject:(id)obj formembers:(NSArray *)members
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (NSString *memberkey in members)
    {
        if(memberkey.length>0)
        {
            if ([obj valueForKey:memberkey] != nil)
            {
                [dict setObject:[obj valueForKey:memberkey] forKey:memberkey];
            }
        }
    }
    
    NSError *jsonError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithDictionary:dict] options:0 error:&jsonError];
    
    if (jsonError!=nil)
    {
        return nil;
    }
    return jsonData;
}

#pragma mark - Create Request

- (NSMutableURLRequest *)urlRequestForURL:(NSURL *)url withObjects:(NSData *)objData
						   withReqCookies:(NSMutableArray *)arrCookies
								 isObject:(bool)customObj
						  withParameters :(NSString *) params
								 reqType :(APIRequestType) requestType
							   reqHeaders:(NSDictionary *) requestHeaders
{
	
	NSMutableURLRequest *request = [NSMutableURLRequest
									requestWithURL:url
									cachePolicy:NSURLRequestUseProtocolCachePolicy
									timeoutInterval:DEFAULT_TIMEOUT];
	
	if (customObj) {
		[request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
		[request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
	}
	else {
		[request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	}
	
	[request addValue:[NSString stringWithFormat:@"%lu", (unsigned long)[objData length]] forHTTPHeaderField:@"Content-Length"];
	[request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setHTTPMethod:StringFromAPIRequestMethod(requestType)];
	[request setHTTPShouldHandleCookies:YES];
	
	
	//Add custom Headers
	for (NSString *key in [requestHeaders allKeys]) {
		[request setValue:[requestHeaders valueForKey:key] forHTTPHeaderField:key];
	}
	
	//Some Universal Request Headers for all request
	[request setValue:@"Pass_Your_Access_Token" forHTTPHeaderField:@"AuthorizationTemp"];
	[request setValue:@"Pass_YourSession_ID" forHTTPHeaderField:@"SessionIdTemp"];
	
	//Set Cookie
	NSMutableArray *allCookies = [NSMutableArray array];
	
	NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
	
	for (NSHTTPCookie *cookie in [storage cookies]) {
		[allCookies addObject:cookie];
	}
	
	if ([allCookies count] > 0) {
		
		NSDictionary *headers = [NSHTTPCookie requestHeaderFieldsWithCookies:allCookies];
		[request setAllHTTPHeaderFields:headers];
	}
	
	[request setHTTPBody:objData];
	
	return request;
}

#pragma mark - Dictionary to QueryString

-(NSString *)serializeParams:(NSDictionary *)params {
	
	/*
	 
	 Convert an NSDictionary to a query string
	 
	 */
	
	NSMutableArray* pairs = [NSMutableArray array];
	for (NSString* key in [params keyEnumerator]) {
		id value = [params objectForKey:key];
		if ([value isKindOfClass:[NSDictionary class]]) {
			for (NSString *subKey in value) {
				NSString* escaped_value = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
																												(CFStringRef)[value objectForKey:subKey],
																												NULL,
																												(CFStringRef)@"!*'();:@&=+$,/?%#[]",
																												kCFStringEncodingUTF8));
				[pairs addObject:[NSString stringWithFormat:@"%@[%@]=%@", key, subKey, escaped_value]];
			}
		} else if ([value isKindOfClass:[NSArray class]]) {
			for (NSString *subValue in value) {
				NSString* escaped_value = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
																												(CFStringRef)subValue,
																												NULL,
																												(CFStringRef)@"!*'();:@&=+$,/?%#[]",
																												kCFStringEncodingUTF8));
				[pairs addObject:[NSString stringWithFormat:@"%@[]=%@", key, escaped_value]];
			}
		} else {
			NSString* escaped_value = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
																											(CFStringRef)[params objectForKey:key],
																											NULL,
																											(CFStringRef)@"!*'();:@&=+$,/?%#[]",
																											kCFStringEncodingUTF8));
			[pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escaped_value]];
			//            [escaped_value release];
		}
	}
	return [pairs componentsJoinedByString:@"&"];
}

#pragma mark - DEVELOPER API DEBUG LOGS

- (void)saveAPIDetailsToCacheForRequestTitle:(NSString *)apiName //Title of API
								  andResponse:(NSURLResponse *)response //Response object
								   andRequest:(NSURLRequest *)request //Request object
						   responseDictionary:(NSDictionary *)responseDict //Formatted response
							   responseString:(NSString *)responseString //Raw response
{
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		
		if (![[AppCacheManagement sharedCacheManager] APILoggingEnabled])
			return;
		
		APIInfoObject *debugDetail = [APIInfoObject modelObjectWithDetails:apiName request:request response:response responseDictionary:responseDict responseString:responseString];
		
		__block NSMutableArray *debugCachedArray;
		[[AppCacheManagement sharedCacheManager] getcachedataArrayFor_:kDeveloperDebugAPILog myMethod:^(BOOL status, NSMutableArray *retrivedArray) {
			if (retrivedArray != nil) {
				debugCachedArray = retrivedArray;
			}
		}];
		if (debugCachedArray.count == kConstMaxDebugAPICount) {
			
			[debugCachedArray removeObjectAtIndex:0];
		}
		
		[debugCachedArray addObject:debugDetail];
		
		[[AppCacheManagement sharedCacheManager] setCacheToUserDefaults:debugCachedArray ForKey:kDeveloperDebugAPILog];
	});
}

#pragma mark - Run On Main Thread

void runOnMainQueueWithoutDeadlocking(void (^block)(void))
{
    if ([NSThread isMainThread])
    {
        block();
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

#pragma mark - String Request enum

NSString *StringFromAPIRequestMethod(APIRequestType apiType)
{
	switch (apiType) {
		case APIRequestMethodGET:      return @"GET";
		case APIRequestMethodPOST:     return @"POST";
		case APIRequestMethodPUT:      return @"PUT";
		case APIRequestMethodDELETE:   return @"DELETE";
		default:                     break;
	}
	return nil;
}

@end
