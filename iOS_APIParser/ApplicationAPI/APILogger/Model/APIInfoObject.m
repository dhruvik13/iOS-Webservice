//
//  APIInfoObject.m
//  iOS_APIParser
//
//  Created by Dhruvik Rao on 9/7/18.
//  Copyright © 2018 Dhruvik Rao. All rights reserved.
//

#import "APIInfoObject.h"

@implementation APIInfoObject

+ (instancetype)modelObjectWithDetails:(NSString *)apiTitle request:(NSURLRequest *)apiRequest response:(NSURLResponse *)apiResponse responseDictionary:(NSDictionary *)responseDict responseString:(NSString *)responseString
{
	return [[self alloc] initWithDetail:apiTitle request:apiRequest response:apiResponse responseDictionary:responseDict responseString:responseString];
}

- (instancetype)initWithDetail:(NSString *)apiTitle request:(NSURLRequest *)apiRequest response:(NSURLResponse *)apiResponse responseDictionary:(NSDictionary *)responseDict responseString:(NSString *)responseString
{
	self = [super init];
	
	self.APITitle = apiTitle;
	self.APIRequest = apiRequest;
	self.APIResponce = apiResponse;
	self.responseDictionary = responseDict;
	self.responseString = responseString;
	
	return self;
}

#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	
	self.APITitle = [aDecoder decodeObjectForKey:@"Title"];
	self.APIRequest = [aDecoder decodeObjectForKey:@"Request"];
	self.APIResponce = [aDecoder decodeObjectForKey:@"Response"];
	self.responseDictionary = [aDecoder decodeObjectForKey:@"ResponseDictionary"];
	self.responseString = [aDecoder decodeObjectForKey:@"ResponseString"];
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:_APITitle forKey:@"Title"];
	[aCoder encodeObject:_APIRequest forKey:@"Request"];
	[aCoder encodeObject:_APIResponce forKey:@"Response"];
	[aCoder encodeObject:_responseDictionary forKey:@"ResponseDictionary"];
	[aCoder encodeObject:_responseString forKey:@"ResponseString"];
}

- (id)copyWithZone:(NSZone *)zone
{
	APIInfoObject *copy = [[APIInfoObject alloc] init];
	
	if (copy) {
		
		copy.APITitle = [self.APITitle copyWithZone:zone];
		copy.APIRequest = [self.APIRequest copyWithZone:zone];
		copy.APIResponce = [self.APIResponce copyWithZone:zone];
		copy.responseDictionary = [self.responseDictionary copyWithZone:zone];
		copy.responseString = [self.responseString copyWithZone:zone];
	}
	
	return copy;
}


@end
