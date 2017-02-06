//
//  APIParser+User.m
//  iOS_APIParser
//
//  Created by Dhruvik Rao on 17/11/15.
//  Copyright © 2015 Dhruvik Rao. All rights reserved.
//

#import "APIParser+User.h"

@implementation APIParser (User)

- (void)URLRequestWithType:(APIType)serviceName
				parameters:(NSString *)parameters
			   cookieValue:(NSMutableArray *)cookies
			 customeobject:(id)object
		  withRequestType :(NSString *) requestType
		withRequestHeaders:(NSDictionary *) headerDictionaries
					 block:(ResponseBlock)block
{
	NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
		
		NSString *URLString;
		NSData   *jsonData;
		NSString *nextStartRecord;
		
		NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
		NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject];
		NSURLSessionDataTask * dataTask;
		
		switch (serviceName)
		{
			case APIUserLogIn:
			{
				URLString = @"";
			}
				break;
			case APIUserGetPosts:
			{
				URLString = @"";
			}
				break;
			case APIGetComments:
			{
				URLString = [NSString stringWithFormat:@"%scomments", ServerPath];
			}
				break;
			default:
				break;
		}
		
		NSMutableURLRequest *request;
		
		if (object == nil) {
			
			jsonData = [parameters dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
			request = [self urlRequestForURL:[NSURL URLWithString:URLString] withObjects:jsonData withReqCookies:cookies isObject:NO withParameters:parameters reqType:requestType reqHeaders:headerDictionaries];
		}
		else {
			
			jsonData = [self dictionaryWithPropertiesOfObject:object];
			request = [self urlRequestForURL:[NSURL URLWithString:URLString] withObjects:jsonData withReqCookies:cookies isObject:YES withParameters:parameters reqType:requestType reqHeaders:headerDictionaries];
		}
		
		__block id Responceobjects = nil;
		
		ShowNetworkIndicator(1);
		
		dataTask = [defaultSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
			{
				if (((NSHTTPURLResponse *)response).statusCode == 401) {
					
					error = [NSError errorWithDomain:@"Session time out" code:401 userInfo:nil];
					
					runOnMainQueueWithoutDeadlocking(^{
						//Show Alert for Session Time Out.
					});
					
					NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
					
					NSMutableArray *responceDataArray;
					
					dispatch_async(dispatch_get_main_queue(), ^(){
						[[NSOperationQueue mainQueue] addOperationWithBlock:^{
							if ( error )
							{
								ShowNetworkIndicator(0);
								block(error,Responceobjects,responseString, nil, responceDataArray, response);
							}
							else
							{
								ShowNetworkIndicator(0);
								block(error,Responceobjects,responseString, nextStartRecord, responceDataArray, response);
							}
						}];
					});
					
					
				}
				else if(error != nil)
				{
					error = [NSError errorWithDomain:@"Request failed" code:401 userInfo:nil];
					
					NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
					NSMutableArray *responceDataArray;
					
					runOnMainQueueWithoutDeadlocking(^{
						//Show Alert for Request Failed.
					});
					
					dispatch_async(dispatch_get_main_queue(), ^(){
						[[NSOperationQueue mainQueue] addOperationWithBlock:^{
							if ( error )
							{
								ShowNetworkIndicator(0);
								block(error,Responceobjects,responseString, nil, responceDataArray, response);
							}
							else
							{
								ShowNetworkIndicator(0);
								block(error,Responceobjects,responseString, nextStartRecord, responceDataArray, response);
							}
						}];
					});
				}
				else if(error == nil)
				{
					
					NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
					
					NSMutableArray *responceDataArray;
					
					[self setSessionIDAndCookieDeviceIDforUrl:URLString withResponce:responseString withParam:parameters withHTTPResponse:response];
					
					if (data.length>0)
					{
						Responceobjects = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
						responceDataArray = [NSMutableArray array];
						
						switch (serviceName)
						{
							case APIUserLogIn:
							{
								/*
								 If Any status has been passed from Server then first check SUCCESS / FAILURE status
								 Then Parse your response within condition
								*/
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
							case APIUserGetPosts:
							{
								/*
								 If Any status has been passed from Server then first check SUCCESS / FAILURE status
								 Then Parse your response within condition
								 */
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
								}
							}
								break;
							case APIGetComments :
							{
								NSLog(@"ResponseString :: %@", responseString);
								responceDataArray = (NSMutableArray *)Responceobjects;
								break;
							}
							default:
								break;
						}
					}
					else if(error != nil)
					{
						runOnMainQueueWithoutDeadlocking(^{
							//Handle Error as per your requirement
						});
					}
					else if(data.length == 0)
					{
						runOnMainQueueWithoutDeadlocking(^{
							//No response Received
						});
					}
					
					dispatch_async(dispatch_get_main_queue(), ^(){
						[[NSOperationQueue mainQueue] addOperationWithBlock:^{
							if ( error )
							{
								ShowNetworkIndicator(0);
								block(error,Responceobjects,responseString, nil, responceDataArray, response);
							}
							else
							{
								ShowNetworkIndicator(0);
								block(error,Responceobjects,responseString, nextStartRecord, responceDataArray,response);
							}
						}];
					});
				}
			}
		}];
		
		[dataTask resume];
	}];
	
	[operation setQueuePriority:NSOperationQueuePriorityVeryHigh];
	[self.WSoperationQueue addOperation:operation];
}



@end
