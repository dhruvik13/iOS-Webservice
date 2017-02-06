//
//  APIParser+User.h
//  iOS_APIParser
//
//  Created by Dhruvik Rao on 17/11/15.
//  Copyright © 2015 Dhruvik Rao. All rights reserved.
//

#import "APIParser.h"

@interface APIParser (User)
typedef enum
{
    APIUserLogIn,
	APIGetComments,
    APIUserGetPosts
} APIType;

- (void)URLRequestWithType:(APIType)serviceName
				parameters:(NSString *)parameters
			   cookieValue:(NSMutableArray *)cookies
			 customeobject:(id)object
		  withRequestType : (NSString *) requestType
		withRequestHeaders:(NSDictionary *) headerDictionaries
					 block:(ResponseBlock)block;

@end
