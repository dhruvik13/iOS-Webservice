//
//  RechargePlansMainObject.m
//  FastTicket
//
//  Created by Dhruvik Rao on 29/05/15.
//  Copyright (c) 2015 Sujav Group. All rights reserved.
//

#import "RechargePlansMainObject.h"

NSString *const kDATAPlan = @"plan";
NSString *const kDATAImageUrl = @"imageUrl";
NSString *const kDATAService = @"service";
NSString *const kDATACircle = @"circle";

NSString *const kDATARechargePlanTypeName = @"planname";
NSString *const kDATAPlanObjects = @"planobjects";


@interface RechargePlansMainObject ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RechargePlansMainObject

@synthesize imageUrl = _imageUrl;
@synthesize service = _service;
@synthesize circle = _circle;


@synthesize rechargePlanTypeName = _rechargePlanTypeName;
@synthesize planObjects = _planObjects;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.imageUrl = [self objectOrNilForKey:kDATAImageUrl fromDictionary:dict];
        self.service = [self objectOrNilForKey:kDATAService fromDictionary:dict];
        self.circle = [self objectOrNilForKey:kDATACircle fromDictionary:dict];
    }
    
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.imageUrl forKey:kDATAImageUrl];
    [mutableDict setValue:self.service forKey:kDATAService];
    [mutableDict setValue:self.circle forKey:kDATACircle];
    [mutableDict setValue:self.rechargePlanTypeName forKey:kDATARechargePlanTypeName];
    [mutableDict setValue:self.planObjects forKey:kDATAPlanObjects];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    self.imageUrl = [aDecoder decodeObjectForKey:kDATAImageUrl];
    self.service = [aDecoder decodeObjectForKey:kDATAService];
    self.circle = [aDecoder decodeObjectForKey:kDATACircle];
    self.rechargePlanTypeName = [aDecoder decodeObjectForKey:kDATARechargePlanTypeName];
    self.planObjects = [aDecoder decodeObjectForKey:kDATAPlanObjects];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_imageUrl forKey:kDATAImageUrl];
    [aCoder encodeObject:_service forKey:kDATAService];
    [aCoder encodeObject:_circle forKey:kDATACircle];
    
    [aCoder encodeObject:_rechargePlanTypeName forKey:kDATARechargePlanTypeName];
    
    [aCoder encodeObject:_planObjects forKey:kDATAPlanObjects];
}

- (id)copyWithZone:(NSZone *)zone
{
    RechargePlansMainObject *copy = [[RechargePlansMainObject alloc] init];
    
    if (copy) {
        
        copy.imageUrl = [self.imageUrl copyWithZone:zone];
        copy.service = [self.service copyWithZone:zone];
        copy.circle = [self.circle copyWithZone:zone];
        copy.rechargePlanTypeName = [self.rechargePlanTypeName copyWithZone:zone];
        copy.planObjects = [self.planObjects copyWithZone:zone];
    }
    
    return copy;
}

@end
