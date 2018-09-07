//
//  APIConstants.h
//  iOS_APIParser
//
//  Created by Dhruvik Rao on 16/11/15.
//  Copyright © 2015 Dhruvik Rao. All rights reserved.
//

#ifndef iOS_APIParser_APIConstants_h
#define iOS_APIParser_APIConstants_h

#define DEFAULT_TIMEOUT 120000.0f

#define ServerPath          "https://jsonplaceholder.typicode.com"

#pragma mark - Test

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000

#define SCREEN_WIDTH                ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIApplication sharedApplication].keyWindow bounds].size.width : [[UIApplication sharedApplication].keyWindow bounds].size.height)

#define SCREEN_HEIGHT               ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIApplication sharedApplication].keyWindow bounds].size.height : [[UIApplication sharedApplication].keyWindow bounds].size.width)

#else

#define SCREEN_WIDTH                ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

#define SCREEN_HEIGHT               ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#endif

#endif
