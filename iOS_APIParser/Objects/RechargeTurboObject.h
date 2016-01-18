//
//  RechargeTurboObject.h
//  FastTicket
//
//  Created by Dhruvik Rao on 07/08/15.
//  Copyright (c) 2015 Sujav Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CircleObject.h"

//Service
@interface Service : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double serviceIdentifier;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end



//Recharge
@interface Recharge : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double rechargeIdentifier;
@property (nonatomic, assign) double amount;
@property (nonatomic, assign) BOOL topUp;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end



//Company
@interface Company : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) Service *service;
@property (nonatomic, assign) double companyIdentifier;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *smsCode;
@property (nonatomic, assign) BOOL rechargeTypeRequired;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSString *updatedOn;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL showRechargeType;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end




//Turbo Main Object

@interface RechargeTurboObject : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, assign) double userId;
@property (nonatomic, strong) CircleObject *circle;
@property (nonatomic, strong) NSArray *recharge;
@property (nonatomic, strong) Company *company;
@property (nonatomic, strong) NSString *circleId;
@property (nonatomic, strong) NSString *companyId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;


@end
