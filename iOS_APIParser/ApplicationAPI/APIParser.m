//
//  APIParser.m
//  iOS_APIParser
//
//  Created by Dhruvik Rao on 16/11/15.
//  Copyright © 2015 Dhruvik Rao. All rights reserved.
//

#import "APIParser.h"

//#import "CacheData.h"


@implementation DegubObject

@synthesize DebugURL;
@synthesize DebugResponce;
@synthesize DebugURLResponceHeader;
@synthesize DebugURLTitle;
@synthesize DebugURLParams;
@synthesize DebugURLCookie;
@synthesize HTTPURLResponse;

@end

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
        
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
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
            ShowNetworkIndicator(0);
        }
        else
        {
            
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object
                               change:change context:context];
    }
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

- (void)postRequestparameters:(NSData *)data customeobject:(id)object block:(ResponseBlock)block
{
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            /******************* Set Url for WebService ********************/
            NSError *error = nil;
			NSString *URLString ;//= [[NSString alloc]init];
            NSData   *jsonData;
            URLString=@"";
            jsonData=data;
			
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:DEFAULT_TIMEOUT];
            NSString *PostParamters;
            ////TRC_DBG(@"PostParamters -- >%@",PostParamters);
            NSData *postData = [PostParamters dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            [request setURL:[NSURL URLWithString:URLString]];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody:postData];
            
            if (jsonData!=nil)
            {
                [request setHTTPBody:jsonData];
                [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            }
            else
            {
                [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            }
            
            id   Responceobjects = nil;
			
			NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
			NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject];

			NSURLSessionDataTask * dataTask;
			dataTask = [defaultSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
				{
					if (data.length>0)
					{
						NSString *responseString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
						
						NSMutableArray *responseArray = [NSMutableArray array];
						
						dispatch_async(dispatch_get_main_queue(), ^(){
							[[NSOperationQueue mainQueue] addOperationWithBlock:^{
								if ( error )
								{
									block(error,Responceobjects,responseString, nil, responseArray, response);
								}
								else
								{
									block(error,Responceobjects,responseString, nil, responseArray, response);
								}
							}];
						});
					}
				}
			}];
			
			
        });
    }];
	
    [operation setQueuePriority:NSOperationQueuePriorityVeryHigh];
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
								 reqType :(NSString *) requestType
							   reqHeaders:(NSDictionary *) requestHeaders
{
	
	NSMutableURLRequest *request = [NSMutableURLRequest
									requestWithURL:url
									cachePolicy:NSURLRequestUseProtocolCachePolicy
									timeoutInterval:DEFAULT_TIMEOUT];
	
	if (customObj) {
		//        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
		[request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
	}
	else {
		[request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	}
	
	[request addValue:[NSString stringWithFormat:@"%lu", (unsigned long)[objData length]] forHTTPHeaderField:@"Content-Length"];
	[request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setHTTPMethod:requestType];
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

#pragma mark - Set Session ID and CookieDevice ID

- (void) setSessionIDAndCookieDeviceIDforUrl : (NSString *) URL withResponce : (NSString*) responseString withParam : (NSString *) params withHTTPResponse : (NSURLResponse *) URLResponse
{
    //Handle Cookie
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
	
#pragma mark - DEVELOPER DEBUG LOG
    
    DegubObject *debugDetail = [DegubObject new];
    debugDetail.DebugURL = URL;
//    debugDetail.DebugURLResponceHeader = [NSString stringWithFormat:@"%@", [arrayHeaders componentsJoinedByString:@""]];
    debugDetail.DebugResponce = responseString;
    debugDetail.DebugURLTitle = [[NSURL URLWithString:URL] lastPathComponent];
    debugDetail.DebugURLParams = params;
    debugDetail.DebugURLCookie = [[storage cookies] componentsJoinedByString:@"\n"];
	debugDetail.HTTPURLResponse = URLResponse;
	
    __block NSMutableArray *debugCachedArray;
    
    if (debugCachedArray.count == 40) {
        
        [debugCachedArray removeObjectAtIndex:0];
    }
	
	//You can cache this Whole debug Array to maintain Request / Response.
    [debugCachedArray addObject:debugDetail];
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

@end
