//
//  RechargePlanCommonObject.h
//  FastTicket
//
//  Created by Dhruvik Rao on 05/06/15.
//  Copyright (c) 2015 Sujav Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RechargePlanCommonObject : NSObject

@property (nonatomic, assign) double talktime;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *validity;
@property (nonatomic, assign) double price;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
