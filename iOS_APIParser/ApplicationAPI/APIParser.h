//
//  APIParser.h
//  iOS_APIParser
//
//  Created by Dhruvik Rao on 16/11/15.
//  Copyright © 2015 Dhruvik Rao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "APIConstants.h"
#import "objc/runtime.h"


@interface DegubObject : NSObject

@property (nonatomic, strong) NSString *DebugURL;
@property (nonatomic, strong) NSString *DebugResponce;
@property (nonatomic, strong) NSString *DebugURLResponceHeader;
@property (nonatomic, strong) NSString *DebugURLTitle;
@property (nonatomic, strong) NSString *DebugURLParams;
@property (nonatomic, strong) NSString *DebugURLCookie;
@property (nonatomic, strong) NSURLResponse *HTTPURLResponse;

@end

typedef void (^ResponseBlock)     (NSError *error, id objects, NSString *responseString,NSString *nextUrl, NSMutableArray *responseArray, NSURLResponse *URLResponseObject);

enum RESPONCESTATUTS
{
    NORESPONCE=0,
    VALID = 1,
    INVALID = 2
};

#define Success                    @"1"
#define InvalidResponce          @"2"
#define Failure                     @"3"

@interface APIParser : NSObject
{
    Reachability *reachability;
}

@property (strong) NSOperationQueue *WSoperationQueue;

+ (id)sharedMediaServer;

- (void)postRequestparameters:(NSData *)data customeobject:(id)object block:(ResponseBlock)block;
- (NSData *)dictionaryWithPropertiesOfObject:(id)obj;
- (NSData *)dictionaryWithmembersOfObject:(id)obj formembers:(NSArray *)members;
- (NSData *)dictionaryToJSONData:(NSDictionary *)dict;

- (NSMutableURLRequest *)urlRequestForURL:(NSURL *)url withObjects:(NSData *)objData
						   withReqCookies:(NSMutableArray *)arrCookies
								 isObject:(bool)customObj
						  withParameters :(NSString *) params
								 reqType :(NSString *) requestType
							   reqHeaders:(NSDictionary *) requestHeaders;

#pragma mark - Set Session ID and CookieDevice ID
- (void) setSessionIDAndCookieDeviceIDforUrl : (NSString *) URL withResponce : (NSString*) responseString  withParam : (NSString *) params withHTTPResponse : (NSURLResponse *) URLResponse;

#pragma mark - Run On Main Thread
void runOnMainQueueWithoutDeadlocking(void (^block)(void));

@end
