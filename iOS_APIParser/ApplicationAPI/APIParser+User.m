//
//  APIParser+User.m
//  iOS_APIParser
//
//  Created by Dhruvik Rao on 17/11/15.
//  Copyright © 2015 Dhruvik Rao. All rights reserved.
//

#import "APIParser+User.h"
#import "FeedObject.h"

@implementation APIParser (User)

- (void)URLRequestWithType:(APIType)serviceName
				parameters:(NSString *)parameters
			   cookieValue:(NSMutableArray *)cookies
			 customeobject:(id)object
		   withRequestType:(APIRequestType) requestType
		withRequestHeaders:(NSDictionary *) headerDictionaries
					 block:(ResponseBlock)block
{
	//Check Internet Connectivity
	NetworkStatus currentStatus = [APP_CONTEXT checkHostReachability];
	
	switch (currentStatus) {
		case ReachableViaWiFi:
		case ReachableViaWWAN:
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
					case APIGetComments:
					{
						URLString = [NSString stringWithFormat:@"%s/posts/1/comments", ServerPath];
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
				
				runOnMainQueueWithoutDeadlocking(^{
					ShowNetworkIndicator(1);
				});
				
				dataTask = [defaultSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
					{
						if (((NSHTTPURLResponse *)response).statusCode == 401) {
							
							error = [NSError errorWithDomain:@"Session time out" code:401 userInfo:nil];
							
							runOnMainQueueWithoutDeadlocking(^{
								//Show Alert for Session Time Out.
							});
							
							NSString *responseString;
							
							NSDictionary *jsonDict;
							
							if (data) {
								responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
								
								jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
							}
							
							NSMutableArray *responceDataArray;
							
							//API cache Logger
							[self saveAPIDetailsToCacheForRequestTitle:[[NSURL URLWithString:URLString] lastPathComponent]
														   andResponse:response
															andRequest:request
													responseDictionary:(jsonDict) ? : nil
														responseString:(responseString) ? : @""];
							
							
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
							NSString *responseString;
							
							NSDictionary *jsonDict;
							
							if (data) {
								responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
								
								jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
							}
							
							
							
							NSMutableArray *responceDataArray;
							
							runOnMainQueueWithoutDeadlocking(^{
								//Show Alert for Request Failed.
							});
							
							//API cache Logger
							[self saveAPIDetailsToCacheForRequestTitle:[[NSURL URLWithString:URLString] lastPathComponent]
														   andResponse:response
															andRequest:request
													responseDictionary:(jsonDict) ? : nil
														responseString:(responseString) ? : @""];
							
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
							
							NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
							
							//API cache Logger
							[self saveAPIDetailsToCacheForRequestTitle:[[NSURL URLWithString:URLString] lastPathComponent]
														   andResponse:response
															andRequest:request
													responseDictionary:jsonDict
														responseString:responseString];
							
							NSMutableArray *responceDataArray;
							
							if (data.length>0)
							{
								Responceobjects = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
								responceDataArray = [NSMutableArray array];
								
								NSLog(@"ResponseString :: %@", responseString);
								
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
											Responceobjects = [(NSDictionary *)Responceobjects valueForKey:@"DATA"];
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
									case APIGetComments :
									{
										//								responceDataArray = (NSMutableArray *)Responceobjects;
										for (NSDictionary *dictionary in Responceobjects) {
											FeedObject *feedObj = [FeedObject modelObjectWithDictionary:dictionary];
											[responceDataArray addObject:feedObj];
										}
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
			break;
		case NotReachable:
		{
			if (!self.APIRequestsArray) {
				self.APIRequestsArray = [NSMutableArray new];
			}
			//Get current selector
			SEL aSelector = @selector(URLRequestWithType:
									  parameters:
									  cookieValue:
									  customeobject:
									  withRequestType:
									  withRequestHeaders:
									  block:);
			NSMethodSignature *signature = [self methodSignatureForSelector:aSelector];
			
			//Set arguments in Invocation
			NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
			[invocation setTarget:self];
			[invocation setSelector:aSelector];
			[invocation setArgument:&serviceName atIndex:2];
			[invocation setArgument:&parameters atIndex:3];
			[invocation setArgument:&cookies atIndex:4];
			[invocation setArgument:&object atIndex:5];
			[invocation setArgument:&requestType atIndex:6];
			[invocation setArgument:&headerDictionaries atIndex:7];
			[invocation setArgument:&block atIndex:8];
			
			//Retaining the arguments to invoke method later on
			[invocation retainArguments];
			
			[self.APIRequestsArray addObject:invocation];
			
			
			if (!self.isnetworkStatusVCPresented) {
				
				InternetConnectionStatusVC *networkStatus = loadViewController(@"InternetConnection", @"idInternetConnectionStatusVC");
				
				//Set specific message for network connectivity
				networkStatus.headerMessage = @"";
				networkStatus.descriptionMessage = @"";
				
				networkStatus.completionBlock = ^(InternetConnectionStatusVC *controller)
				{
					
					//Network connected, call previous WS
					for (NSInvocation *WSInvocationCall in self.APIRequestsArray) {
						//Invoke (call) stored WS functions
						[WSInvocationCall performSelector:@selector(invoke) withObject:nil afterDelay:0.0];
					}
					self.APIRequestsArray = nil;
					
					self.isnetworkStatusVCPresented = NO;
				};
				
				self.isnetworkStatusVCPresented = YES;
				
				UIViewController *vc = APP_CONTEXT.window.rootViewController;
				
				if (!APP_CONTEXT.appNavigationController) {
					APP_CONTEXT.appNavigationController = [[UINavigationController alloc] init];
				}
				
				UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:networkStatus];
				
				[vc presentViewController:navigationController animated:YES
							   completion:^{
								   
							   }];
			}
		}
			break;
		default:
			break;
	}
}



@end
