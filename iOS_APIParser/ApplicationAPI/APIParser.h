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
#import "InternetConnectionStatusVC.h"


typedef enum
{
	APIRequestMethodGET,
	APIRequestMethodPOST,
	APIRequestMethodDELETE,
	APIRequestMethodPUT
} APIRequestType;

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

@property (nonatomic, assign) APIRequestType requestType;

@property (strong) NSOperationQueue *WSoperationQueue;

@property (nonatomic, assign) BOOL isnetworkStatusVCPresented;

@property (nonatomic, strong) NSMutableArray *APIRequestsArray;

+ (id)sharedMediaServer;

- (NSData *)dictionaryWithPropertiesOfObject:(id)obj;
- (NSData *)dictionaryWithmembersOfObject:(id)obj formembers:(NSArray *)members;
- (NSData *)dictionaryToJSONData:(NSDictionary *)dict;

- (NSMutableURLRequest *)urlRequestForURL:(NSURL *)url withObjects:(NSData *)objData
						   withReqCookies:(NSMutableArray *)arrCookies
								 isObject:(bool)customObj
						  withParameters :(NSString *) params
								 reqType :(APIRequestType) requestType
							   reqHeaders:(NSDictionary *) requestHeaders;

#pragma mark - Cancel all API request with operation
- (void)cancelALLCurrentlyExecutingRequest;

#pragma mark - Dictionary to QueryString
-(NSString *)serializeParams:(NSDictionary *)params;

#pragma mark - DEVELOPER API DEBUG LOGS
- (void) saveAPIDetailsToCacheForRequestTitle:(NSString *)apiName //Title of API
								  andResponse:(NSURLResponse *)response //Response object
								   andRequest:(NSURLRequest *)request //Request object
						   responseDictionary:(NSDictionary *)responseDict //Formatted response
							   responseString:(NSString *)responseString; //Raw response

#pragma mark - Run On Main Thread
void runOnMainQueueWithoutDeadlocking(void (^block)(void));

@end
