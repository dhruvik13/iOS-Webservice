//
//  RechargePlanCommonObject.m
//  FastTicket
//
//  Created by Dhruvik Rao on 05/06/15.
//  Copyright (c) 2015 Sujav Group. All rights reserved.
//

#import "RechargePlanCommonObject.h"

NSString *const kRechargeCommonTalktime = @"talktime";
NSString *const kRechargeCommonDetail = @"detail";
NSString *const kRechargeCommonValidity = @"validity";
NSString *const kRechargeCommonPrice = @"price";

@interface RechargePlanCommonObject ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RechargePlanCommonObject

@synthesize talktime = _talktime;
@synthesize detail = _detail;
@synthesize validity = _validity;
@synthesize price = _price;

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
        self.talktime = [[self objectOrNilForKey:kRechargeCommonTalktime fromDictionary:dict] doubleValue];
        self.detail = [self objectOrNilForKey:kRechargeCommonDetail fromDictionary:dict];
        self.validity = [self objectOrNilForKey:kRechargeCommonValidity fromDictionary:dict];
        self.price = [[self objectOrNilForKey:kRechargeCommonPrice fromDictionary:dict] doubleValue];
    }
    
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.talktime] forKey:kRechargeCommonTalktime];
    [mutableDict setValue:self.detail forKey:kRechargeCommonDetail];
    [mutableDict setValue:self.validity forKey:kRechargeCommonValidity];
    [mutableDict setValue:[NSNumber numberWithDouble:self.price] forKey:kRechargeCommonPrice];
    
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
    
    self.talktime = [aDecoder decodeDoubleForKey:kRechargeCommonTalktime];
    self.detail = [aDecoder decodeObjectForKey:kRechargeCommonDetail];
    self.validity = [aDecoder decodeObjectForKey:kRechargeCommonValidity];
    self.price = [aDecoder decodeDoubleForKey:kRechargeCommonPrice];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeDouble:_talktime forKey:kRechargeCommonTalktime];
    [aCoder encodeObject:_detail forKey:kRechargeCommonDetail];
    [aCoder encodeObject:_validity forKey:kRechargeCommonValidity];
    [aCoder encodeDouble:_price forKey:kRechargeCommonPrice];
}

- (id)copyWithZone:(NSZone *)zone
{
    RechargePlanCommonObject *copy = [[RechargePlanCommonObject alloc] init];
    
    if (copy) {
        
        copy.talktime = self.talktime;
        copy.detail = [self.detail copyWithZone:zone];
        copy.validity = [self.validity copyWithZone:zone];
        copy.price = self.price;
    }
    
    return copy;
}

@end
