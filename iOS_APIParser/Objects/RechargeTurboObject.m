//
//  RechargeTurboObject.m
//  FastTicket
//
//  Created by Dhruvik Rao on 07/08/15.
//  Copyright (c) 2015 Sujav Group. All rights reserved.
//

#import "RechargeTurboObject.h"


//Service
NSString *const kServiceId = @"id";
NSString *const kServiceName = @"name";


@interface Service ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Service

@synthesize serviceIdentifier = _serviceIdentifier;
@synthesize name = _name;


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
        self.serviceIdentifier = [[self objectOrNilForKey:kServiceId fromDictionary:dict] doubleValue];
        self.name = [self objectOrNilForKey:kServiceName fromDictionary:dict];
    }
    
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.serviceIdentifier] forKey:kServiceId];
    [mutableDict setValue:self.name forKey:kServiceName];
    
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
    
    self.serviceIdentifier = [aDecoder decodeDoubleForKey:kServiceId];
    self.name = [aDecoder decodeObjectForKey:kServiceName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeDouble:_serviceIdentifier forKey:kServiceId];
    [aCoder encodeObject:_name forKey:kServiceName];
}

- (id)copyWithZone:(NSZone *)zone
{
    Service *copy = [[Service alloc] init];
    
    if (copy) {
        
        copy.serviceIdentifier = self.serviceIdentifier;
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end



//Company
NSString *const kCompanyService = @"service";
NSString *const kCompanyId = @"id";
NSString *const kCompanyImageUrl = @"imageUrl";
NSString *const kCompanySmsCode = @"smsCode";
NSString *const kCompanyRechargeTypeRequired = @"rechargeTypeRequired";
NSString *const kCompanyLabel = @"label";
NSString *const kCompanyUpdatedOn = @"updatedOn";
NSString *const kCompanyName = @"name";
NSString *const kShowRechargeType = @"showRechargeType";

@interface Company ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Company

@synthesize service = _service;
@synthesize companyIdentifier = _companyIdentifier;
@synthesize imageUrl = _imageUrl;
@synthesize smsCode = _smsCode;
@synthesize rechargeTypeRequired = _rechargeTypeRequired;
@synthesize label = _label;
@synthesize updatedOn = _updatedOn;
@synthesize name = _name;
@synthesize showRechargeType = _showRechargeType;

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
        self.service = [Service modelObjectWithDictionary:[dict objectForKey:kCompanyService]];
        self.companyIdentifier = [[self objectOrNilForKey:kCompanyId fromDictionary:dict] doubleValue];
        self.imageUrl = [self objectOrNilForKey:kCompanyImageUrl fromDictionary:dict];
        self.smsCode = [self objectOrNilForKey:kCompanySmsCode fromDictionary:dict];
        self.rechargeTypeRequired = [[self objectOrNilForKey:kCompanyRechargeTypeRequired fromDictionary:dict] boolValue];
        self.showRechargeType = [[self objectOrNilForKey:kShowRechargeType fromDictionary:dict] boolValue];
        self.label = [self objectOrNilForKey:kCompanyLabel fromDictionary:dict];
        self.updatedOn = [self objectOrNilForKey:kCompanyUpdatedOn fromDictionary:dict];
        self.name = [self objectOrNilForKey:kCompanyName fromDictionary:dict];
    }
    
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.service dictionaryRepresentation] forKey:kCompanyService];
    [mutableDict setValue:[NSNumber numberWithDouble:self.companyIdentifier] forKey:kCompanyId];
    [mutableDict setValue:self.imageUrl forKey:kCompanyImageUrl];
    [mutableDict setValue:self.smsCode forKey:kCompanySmsCode];
    [mutableDict setValue:[NSNumber numberWithBool:self.rechargeTypeRequired] forKey:kCompanyRechargeTypeRequired];
    [mutableDict setValue:[NSNumber numberWithBool:self.showRechargeType] forKey:kShowRechargeType];
    [mutableDict setValue:self.label forKey:kCompanyLabel];
    [mutableDict setValue:self.updatedOn forKey:kCompanyUpdatedOn];
    [mutableDict setValue:self.name forKey:kCompanyName];
    
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
    
    self.service = [aDecoder decodeObjectForKey:kCompanyService];
    self.companyIdentifier = [aDecoder decodeDoubleForKey:kCompanyId];
    self.imageUrl = [aDecoder decodeObjectForKey:kCompanyImageUrl];
    self.smsCode = [aDecoder decodeObjectForKey:kCompanySmsCode];
    self.rechargeTypeRequired = [aDecoder decodeBoolForKey:kCompanyRechargeTypeRequired];
    self.showRechargeType = [aDecoder decodeBoolForKey:kShowRechargeType];
    self.label = [aDecoder decodeObjectForKey:kCompanyLabel];
    self.updatedOn = [aDecoder decodeObjectForKey:kCompanyUpdatedOn];
    self.name = [aDecoder decodeObjectForKey:kCompanyName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_service forKey:kCompanyService];
    [aCoder encodeDouble:_companyIdentifier forKey:kCompanyId];
    [aCoder encodeObject:_imageUrl forKey:kCompanyImageUrl];
    [aCoder encodeObject:_smsCode forKey:kCompanySmsCode];
    [aCoder encodeBool:_rechargeTypeRequired forKey:kCompanyRechargeTypeRequired];
    [aCoder encodeBool:_showRechargeType forKey:kShowRechargeType];
    [aCoder encodeObject:_label forKey:kCompanyLabel];
    [aCoder encodeObject:_updatedOn forKey:kCompanyUpdatedOn];
    [aCoder encodeObject:_name forKey:kCompanyName];
}

- (id)copyWithZone:(NSZone *)zone
{
    Company *copy = [[Company alloc] init];
    
    if (copy) {
        
        copy.service = [self.service copyWithZone:zone];
        copy.companyIdentifier = self.companyIdentifier;
        copy.imageUrl = [self.imageUrl copyWithZone:zone];
        copy.smsCode = [self.smsCode copyWithZone:zone];
        copy.rechargeTypeRequired = self.rechargeTypeRequired;
        copy.showRechargeType = self.showRechargeType;
        copy.label = [self.label copyWithZone:zone];
        copy.updatedOn = [self.updatedOn copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end



//Recharge

NSString *const kRechargeId = @"id";
NSString *const kRechargeAmount = @"amount";
NSString *const kRechargeTopUp = @"topUp";


@interface Recharge ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Recharge

@synthesize rechargeIdentifier = _rechargeIdentifier;
@synthesize amount = _amount;
@synthesize topUp = _topUp;


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
        self.rechargeIdentifier = [[self objectOrNilForKey:kRechargeId fromDictionary:dict] doubleValue];
        self.amount = [[self objectOrNilForKey:kRechargeAmount fromDictionary:dict] doubleValue];
        self.topUp = [[self objectOrNilForKey:kRechargeTopUp fromDictionary:dict] boolValue];
    }
    
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.rechargeIdentifier] forKey:kRechargeId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.amount] forKey:kRechargeAmount];
    [mutableDict setValue:[NSNumber numberWithBool:self.topUp] forKey:kRechargeTopUp];
    
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
    
    self.rechargeIdentifier = [aDecoder decodeDoubleForKey:kRechargeId];
    self.amount = [aDecoder decodeDoubleForKey:kRechargeAmount];
    self.topUp = [aDecoder decodeBoolForKey:kRechargeTopUp];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeDouble:_rechargeIdentifier forKey:kRechargeId];
    [aCoder encodeDouble:_amount forKey:kRechargeAmount];
    [aCoder encodeBool:_topUp forKey:kRechargeTopUp];
}

- (id)copyWithZone:(NSZone *)zone
{
    Recharge *copy = [[Recharge alloc] init];
    
    if (copy) {
        
        copy.rechargeIdentifier = self.rechargeIdentifier;
        copy.amount = self.amount;
        copy.topUp = self.topUp;
    }
    
    return copy;
}


@end



//RechargeTurbo Main Object

NSString *const kRechargeTurboMobile = @"mobile";
NSString *const kRechargeTurboUserId = @"userId";
NSString *const kRechargeTurboCircle = @"circle";
NSString *const kRechargeTurboRecharge = @"recharge";
NSString *const kRechargeTurboCompany = @"company";
NSString *const kRechargeTurboCircleId = @"circleId";
NSString *const kRechargeTurboCompanyId = @"companyId";

@interface RechargeTurboObject ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RechargeTurboObject


@synthesize mobile = _mobile;
@synthesize userId = _userId;
@synthesize circle = _circle;
@synthesize recharge = _recharge;
@synthesize company = _company;
@synthesize circleId = _circleId;
@synthesize companyId = _companyId;


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
        self.mobile = [self objectOrNilForKey:kRechargeTurboMobile fromDictionary:dict];
        self.userId = [[self objectOrNilForKey:kRechargeTurboUserId fromDictionary:dict] doubleValue];
        self.circle = [CircleObject modelObjectWithDictionary:[dict objectForKey:kRechargeTurboCircle]];
        
        NSObject *receivedRecharge = [dict objectForKey:kRechargeTurboRecharge];
        NSMutableArray *parsedRecharge = [NSMutableArray array];
        if ([receivedRecharge isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedRecharge) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedRecharge addObject:[Recharge modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedRecharge isKindOfClass:[NSDictionary class]]) {
            [parsedRecharge addObject:[Recharge modelObjectWithDictionary:(NSDictionary *)receivedRecharge]];
        }
        
        self.recharge = [NSArray arrayWithArray:parsedRecharge];
        self.company = [Company modelObjectWithDictionary:[dict objectForKey:kRechargeTurboCompany]];
        self.circleId = [self objectOrNilForKey:kRechargeTurboCircleId fromDictionary:dict];
        self.companyId = [self objectOrNilForKey:kRechargeTurboCompanyId fromDictionary:dict];
    }
    
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.mobile forKey:kRechargeTurboMobile];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kRechargeTurboUserId];
    [mutableDict setValue:[self.circle dictionaryRepresentation] forKey:kRechargeTurboCircle];
    
    NSMutableArray *tempArrayForRecharge = [NSMutableArray array];
    for (NSObject *subArrayObject in self.recharge) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRecharge addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRecharge addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRecharge] forKey:kRechargeTurboRecharge];
    [mutableDict setValue:[self.company dictionaryRepresentation] forKey:kRechargeTurboCompany];
    [mutableDict setValue:self.circleId forKey:kRechargeTurboCircleId];
    [mutableDict setValue:self.companyId forKey:kRechargeTurboCompanyId];
    
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
    
    self.mobile = [aDecoder decodeObjectForKey:kRechargeTurboMobile];
    self.userId = [aDecoder decodeDoubleForKey:kRechargeTurboUserId];
    self.circle = [aDecoder decodeObjectForKey:kRechargeTurboCircle];
    self.recharge = [aDecoder decodeObjectForKey:kRechargeTurboRecharge];
    self.company = [aDecoder decodeObjectForKey:kRechargeTurboCompany];
    self.circleId = [aDecoder decodeObjectForKey:kRechargeTurboCircleId];
    self.companyId = [aDecoder decodeObjectForKey:kRechargeTurboCompanyId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_mobile forKey:kRechargeTurboMobile];
    [aCoder encodeDouble:_userId forKey:kRechargeTurboUserId];
    [aCoder encodeObject:_circle forKey:kRechargeTurboCircle];
    [aCoder encodeObject:_recharge forKey:kRechargeTurboRecharge];
    [aCoder encodeObject:_company forKey:kRechargeTurboCompany];
    [aCoder encodeObject:_circleId forKey:kRechargeTurboCircleId];
    [aCoder encodeObject:_companyId forKey:kRechargeTurboCompanyId];
}

- (id)copyWithZone:(NSZone *)zone
{
    RechargeTurboObject *copy = [[RechargeTurboObject alloc] init];
    
    if (copy) {
        
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.userId = self.userId;
        copy.circle = [self.circle copyWithZone:zone];
        copy.recharge = [self.recharge copyWithZone:zone];
        copy.company = [self.company copyWithZone:zone];
        copy.circleId = [self.circleId copyWithZone:zone];
        copy.companyId = [self.companyId copyWithZone:zone];
    }
    
    return copy;
}

@end
