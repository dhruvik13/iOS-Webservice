//
//  FeedObject.h
//  iOS_APIParser
//
//  Created by Dhruvik Rao on 9/7/18.
//  Copyright © 2018 Dhruvik Rao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedObject : NSObject

@property (nonatomic, strong) NSString *email;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, assign) double postId;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
