//
//  UIViewController+Helper.h
//  iOS_APIParser
//
//  Created by Dhruvik Rao on 9/7/18.
//  Copyright © 2018 Dhruvik Rao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ShakeDirection) {
	/** Shake left and right */
	ShakeDirectionHorizontal,
	/** Shake up and down */
	ShakeDirectionVertical
};

@interface UIViewController (Helper)

//Shake Animation
- (void)_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection forView:(UIView*)view completion:(void (^)(void))completionHandler ;

@end
