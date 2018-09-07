//
//  APIInfoObject.h
//  iOS_APIParser
//
//  Created by Dhruvik Rao on 9/7/18.
//  Copyright © 2018 Dhruvik Rao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIInfoObject : NSObject

@property (nonatomic, strong) NSString *APITitle;

@property (nonatomic, strong) NSURLRequest *APIRequest;

@property (nonatomic, strong) NSURLResponse *APIResponce;

@property (nonatomic, strong) NSDictionary *responseDictionary;

@property (nonatomic, strong) NSString *responseString;

+ (instancetype)modelObjectWithDetails:(NSString *)apiTitle request:(NSURLRequest *)apiRequest response:(NSURLResponse *)apiResponse responseDictionary:(NSDictionary *)responseDict responseString:(NSString *)responseString;

@end
