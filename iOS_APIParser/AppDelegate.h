//
//  AppDelegate.h
//  iOS_APIParser
//
//  Created by Dhruvik Rao on 16/11/15.
//  Copyright © 2015 Dhruvik Rao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

#pragma mark - Check Host Reachability
- (NetworkStatus) checkHostReachability;

@property (nonatomic, strong) Reachability *hostReachability;

@property (nonatomic, strong) UINavigationController *appNavigationController;

- (UIViewController*) topMostController;

@end

