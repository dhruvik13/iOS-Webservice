//
//  RechargePlansMainObject.h
//  FastTicket
//
//  Created by Dhruvik Rao on 29/05/15.
//  Copyright (c) 2015 Sujav Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RechargePlansMainObject : NSObject

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *service;
@property (nonatomic, strong) NSString *circle;

@property (nonatomic, strong) NSString *rechargePlanTypeName;
@property (nonatomic, strong) NSArray *planObjects;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
