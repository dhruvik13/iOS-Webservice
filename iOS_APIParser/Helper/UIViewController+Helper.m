//
//  UIViewController+Helper.m
//  iOS_APIParser
//
//  Created by Dhruvik Rao on 9/7/18.
//  Copyright © 2018 Dhruvik Rao. All rights reserved.
//

#import "UIViewController+Helper.h"

@implementation UIViewController (Helper)

#pragma mark - Shake Animation

- (void)_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection forView:(UIView*)view completion:(void (^)(void))completionHandler {
	
	__weak UIViewController *weakSelf = self;
	
	[UIView animateWithDuration:interval animations:^{
		view.layer.affineTransform = (shakeDirection == ShakeDirectionHorizontal) ? CGAffineTransformMakeTranslation(delta * direction, 0) : CGAffineTransformMakeTranslation(0, delta * direction);
	} completion:^(BOOL finished) {
		if(current >= times) {
			[UIView animateWithDuration:interval animations:^{
				view.layer.affineTransform = CGAffineTransformIdentity;
			} completion:^(BOOL finished){
				if (completionHandler != nil) {
					completionHandler();
				}
			}];
			return;
		}
		[weakSelf _shake:(times - 1)
			   direction:direction * -1
			currentTimes:current + 1
			   withDelta:delta
				   speed:interval
		  shakeDirection:shakeDirection
				 forView:view
			  completion:completionHandler];
	}];
}

@end
