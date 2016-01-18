//
//  AppMacros.h
//  iOS_APIParser
//
//  Created by Dhruvik Rao on 16/11/15.
//  Copyright © 2015 Dhruvik Rao. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef AppMacros_h
#define AppMacros_h

#pragma mark -
#pragma mark - App Delegate

#define APP_CONTEXT             ((AppDelegate*)[[UIApplication sharedApplication] delegate])

#define IOS_NEWER_OR_EQUAL_TO_X(XX)    ( [ [ [ UIDevice currentDevice ] systemVersion ] floatValue ] >= XX )

#pragma mark -
#pragma mark - Network Indicator

#define ShowNetworkIndicator(BOOL) [UIApplication sharedApplication].networkActivityIndicatorVisible = BOOL


#endif /* AppMacros_h */
