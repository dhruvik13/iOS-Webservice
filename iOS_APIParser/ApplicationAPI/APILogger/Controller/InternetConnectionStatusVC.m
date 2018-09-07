//
//  InternetConnectionStatusVC.m
//  iOS_APIParser
//
//  Created by Dhruvik Rao on 9/7/18.
//  Copyright © 2018 Dhruvik Rao. All rights reserved.
//

#import "InternetConnectionStatusVC.h"
#import "UIViewController+Helper.h"

@interface InternetConnectionStatusVC ()
{
	IBOutlet UILabel *lblInternetStatusHeader;
	IBOutlet UILabel *lblInternetStatusDescription;
	IBOutlet UIImageView *imgInternetStatus;
	IBOutlet UIButton *btnTryAgain;
}
@end

@implementation InternetConnectionStatusVC

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = @"Newtwork Issue!";
	
	[self.navigationController.navigationBar setTitleTextAttributes:@{
																	  NSForegroundColorAttributeName : RGBCOLOR(49, 146, 181, 1.0),
																	  NSFontAttributeName : [UIFont systemFontOfSize:20.0]
																	  }];
	
	//Add Right bar button
	UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeSystem];
	[btnRight setFrame:CGRectMake(0, 0, 40, 40)];
	[btnRight setTintColor:[UIColor whiteColor]];
	[btnRight setImage:[UIImage imageNamed:@"close_navigationbar"] forState:UIControlStateNormal];
	[btnRight addTarget:self action:@selector(closeConnectivityView:) forControlEvents:UIControlEventTouchUpInside];
	
	[btnRight setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
	
	btnRight.imageView.contentMode = UIViewContentModeScaleAspectFit;
	btnRight.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
	btnRight.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	
	UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
	[rightBarButton setTintColor:[UIColor whiteColor]];
	//	self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
}

-(UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
	return UIBarPositionTopAttached;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Close presented View

- (IBAction)closeConnectivityView:(id)sender {
	
	[self dismissViewControllerAnimated:YES completion:^{
		
	}];
}

#pragma mark - Try Again Click

- (IBAction)retryClicked:(id)sender {
	
	UIButton *btnSender = (UIButton *)sender;
	
	UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	indicator.tag = 200;
	indicator.tintColor = [UIColor whiteColor];
	CGFloat halfButtonHeight = btnSender.bounds.size.height / 2;
	CGFloat buttonWidth = btnSender.bounds.size.width;
	indicator.center = CGPointMake(buttonWidth - halfButtonHeight , halfButtonHeight);
	indicator.hidesWhenStopped = YES;
	[btnSender addSubview:indicator];
	[indicator startAnimating];
	
	[btnTryAgain setEnabled:NO];
	
	[self checkHostReachabilityWithIndicator:indicator];
}


- (void) checkHostReachabilityWithIndicator :(UIActivityIndicatorView*)indicator {
	
	NetworkStatus currentStatus = [APP_CONTEXT checkHostReachability];
	
	switch (currentStatus) {
		case NotReachable:
		{
			__weak UIActivityIndicatorView *weakindicator = indicator;
			
			[self _shake:7 direction:1 currentTimes:0 withDelta:2 speed:0.06 shakeDirection:ShakeDirectionHorizontal forView:btnTryAgain completion:^{
				
				[weakindicator stopAnimating];
				[weakindicator removeFromSuperview];
				
				[btnTryAgain setEnabled:YES];
			}];
		}
			break;
		case ReachableViaWiFi:
		case ReachableViaWWAN:
		{
			[self dismissViewControllerAnimated:YES completion:^{
				
				if (self.completionBlock) {
					self.completionBlock(self);
				}
			}];
			
		}
	}
}

@end
