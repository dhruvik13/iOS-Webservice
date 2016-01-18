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
    APIUserGetPosts
} UserAPIType;

- (void)UserRequestWithType:(UserAPIType)serviceName
                 parameters:(NSString *)parameters
                cookieValue:(NSMutableArray *)cookies
              customeobject:(id)object
                      block:(ResponseBlock)block;

@end
