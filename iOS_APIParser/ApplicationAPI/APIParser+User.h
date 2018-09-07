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
	APIGetComments
} APIType;

- (void)URLRequestWithType:(APIType)serviceName
				parameters:(NSString *)parameters
			   cookieValue:(NSMutableArray *)cookies
			 customeobject:(id)object
		   withRequestType:(APIRequestType) requestType
		withRequestHeaders:(NSDictionary *) headerDictionaries
					 block:(ResponseBlock)block;

@end
