//
//  FeedObject.m
//  iOS_APIParser
//
//  Created by Dhruvik Rao on 9/7/18.
//  Copyright © 2018 Dhruvik Rao. All rights reserved.
//

#import "FeedObject.h"

NSString *const kBaseClassEmail = @"email";
NSString *const kBaseClassId = @"id";
NSString *const kBaseClassPostId = @"postId";
NSString *const kBaseClassBody = @"body";
NSString *const kBaseClassName = @"name";

@interface FeedObject ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FeedObject

@synthesize email = _email;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize postId = _postId;
@synthesize body = _body;
@synthesize name = _name;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
	return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
	self = [super init];
	
	// This check serves to make sure that a non-NSDictionary object
	// passed into the model class doesn't break the parsing.
	if (self && [dict isKindOfClass:[NSDictionary class]]) {
		self.email = [self objectOrNilForKey:kBaseClassEmail fromDictionary:dict];
		self.internalBaseClassIdentifier = [[self objectOrNilForKey:kBaseClassId fromDictionary:dict] doubleValue];
		self.postId = [[self objectOrNilForKey:kBaseClassPostId fromDictionary:dict] doubleValue];
		self.body = [self objectOrNilForKey:kBaseClassBody fromDictionary:dict];
		self.name = [self objectOrNilForKey:kBaseClassName fromDictionary:dict];
	}
	
	return self;
	
}

- (NSDictionary *)dictionaryRepresentation {
	NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.email forKey:kBaseClassEmail];
	[mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kBaseClassId];
	[mutableDict setValue:[NSNumber numberWithDouble:self.postId] forKey:kBaseClassPostId];
	[mutableDict setValue:self.body forKey:kBaseClassBody];
	[mutableDict setValue:self.name forKey:kBaseClassName];
	
	return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
	return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
	id object = [dict objectForKey:aKey];
	return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
	
	self.email = [aDecoder decodeObjectForKey:kBaseClassEmail];
	self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kBaseClassId];
	self.postId = [aDecoder decodeDoubleForKey:kBaseClassPostId];
	self.body = [aDecoder decodeObjectForKey:kBaseClassBody];
	self.name = [aDecoder decodeObjectForKey:kBaseClassName];
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:_email forKey:kBaseClassEmail];
	[aCoder encodeDouble:_internalBaseClassIdentifier forKey:kBaseClassId];
	[aCoder encodeDouble:_postId forKey:kBaseClassPostId];
	[aCoder encodeObject:_body forKey:kBaseClassBody];
	[aCoder encodeObject:_name forKey:kBaseClassName];
}

- (id)copyWithZone:(NSZone *)zone {
	FeedObject *copy = [[FeedObject alloc] init];
	
	if (copy) {
		
		copy.email = [self.email copyWithZone:zone];
		copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
		copy.postId = self.postId;
		copy.body = [self.body copyWithZone:zone];
		copy.name = [self.name copyWithZone:zone];
	}
	
	return copy;
}

@end
