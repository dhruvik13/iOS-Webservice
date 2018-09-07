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

#pragma mark -
#pragma mark - View

#define getStoryboard(StoryboardWithName) [UIStoryboard storyboardWithName:[NSString stringWithFormat:@"%@", StoryboardWithName] bundle:NULL]
#define loadViewController(StoryBoardName, VCIdentifer) [getStoryboard(StoryBoardName)instantiateViewControllerWithIdentifier:VCIdentifer]

#define RGBCOLOR(r, g, b, alp) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:alp]

#define Screen_Height  [UIScreen mainScreen].bounds.size.height
#define Screen_Width  [UIScreen mainScreen].bounds.size.width

#endif /* AppMacros_h */
