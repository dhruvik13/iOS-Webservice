//
//  APIParser+User.m
//  iOS_APIParser
//
//  Created by Dhruvik Rao on 17/11/15.
//  Copyright © 2015 Dhruvik Rao. All rights reserved.
//

#import "APIParser+User.h"

@implementation APIParser (User)

- (void)UserRequestWithType:(UserAPIType)serviceName
                 parameters:(NSString *)parameters
                cookieValue:(NSMutableArray *)cookies
              customeobject:(id)object
                      block:(ResponseBlock)block
{
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        
        NSError *error = nil;
        NSHTTPURLResponse *response = nil;
        NSString *URLString;
        NSData   *jsonData;
        NSString *nextStartRecord;
        
        switch (serviceName)
        {
            case APIUserLogIn:
            {
                
            }
                break;
            case APIUserGetPosts:
            {
                
            }
                break;
            default:
                break;
        }
        
        NSMutableURLRequest *request;// = [NSMutableURLRequest new];
        
        if (object == nil) {
            
            jsonData = [parameters dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            request = [self urlRequestForURL:[NSURL URLWithString:URLString] withObjects:jsonData withReqCookies:cookies isObject:NO];
        }
        else {
            
            jsonData = [self dictionaryWithPropertiesOfObject:object];
            request = [self urlRequestForURL:[NSURL URLWithString:URLString] withObjects:jsonData withReqCookies:cookies isObject:YES];
        }
        
        id   Responceobjects = nil;
        ShowNetworkIndicator(1);
        
        NSData   *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSMutableArray *responceDataArray;
        
        [self setSessionIDAndCookieDeviceIDforUrl:URLString withResponce:responseString withParam:parameters];
        
        if (data.length>0)
        {
            Responceobjects = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            responceDataArray = [NSMutableArray array];
            
            switch (serviceName)
            {
                case APIUserLogIn:
                {
                    if ([[[(NSDictionary *)Responceobjects valueForKey:@"STATUS"] stringValue] isEqualToString:Success])
                    {
                        Responceobjects = [(NSDictionary *)Responceobjects valueForKey:@"DATA"] ;
                    }
                    else if ([[[(NSDictionary *)Responceobjects valueForKey:@"STATUS"] stringValue] isEqualToString:Failure])
                    {
                        NSDictionary *errorDict = [[NSDictionary alloc]initWithObjectsAndKeys:[(NSDictionary *)Responceobjects valueForKey:@"MESSAGE"], @"msg", nil];
                        error = [NSError errorWithDomain:@"Internal Error" code:2 userInfo:errorDict];
                    }
                    else if ([[[(NSDictionary *)Responceobjects valueForKey:@"STATUS"] stringValue] isEqualToString:InvalidResponce])
                    {
                        NSDictionary *errorDict = [[NSDictionary alloc]initWithObjectsAndKeys:[(NSDictionary *)Responceobjects valueForKey:@"MESSAGE"], @"msg", nil];
                        error = [NSError errorWithDomain:@"Internal Error" code:2 userInfo:errorDict];
                    }
                }
                    break;
                default:
                    break;
            }
        }
        else if(error != nil)
        {
            runOnMainQueueWithoutDeadlocking(^{
                
            });
        }
        else if(data.length == 0)
        {
            runOnMainQueueWithoutDeadlocking(^{
                
            });
        }
        
        dispatch_async(dispatch_get_main_queue(), ^(){
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if ( error )
                {
                    ShowNetworkIndicator(0);
                    block(error,Responceobjects,responseString, nil, responceDataArray);
                }
                else
                {
                    ShowNetworkIndicator(0);
                    block(error,Responceobjects,responseString, nextStartRecord, responceDataArray);
                }
            }];
        });
    }];
    
    [operation setQueuePriority:NSOperationQueuePriorityVeryHigh];
    [self.WSoperationQueue addOperation:operation];
}



@end
