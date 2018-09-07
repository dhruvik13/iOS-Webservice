//
//  InternetConnectionStatusVC.h
//  iOS_APIParser
//
//  Created by Dhruvik Rao on 9/7/18.
//  Copyright © 2018 Dhruvik Rao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InternetConnectionStatusVC : UIViewController

typedef void (^NetworkCompletion)(InternetConnectionStatusVC *);

@property (nonatomic, readwrite) NSString *headerMessage;
@property (nonatomic, readwrite) NSString *descriptionMessage;

//Parent View Controller
@property (nonatomic, strong) UIViewController *parentVC;

//Completion block
@property (nonatomic,copy) NetworkCompletion completionBlock;

@end
