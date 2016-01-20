//
//  OrderSummaryVC.h
//  FastTicket
//
//  Created by Manan Sheth on 9/9/15.
//  Copyright (c) 2015 Sujav Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderSummaryViewDelegate <NSObject>

@optional

- (void)clickForDismissView;

@end

@interface OrderSummaryVC : UIViewController

@property (strong, nonatomic) id<OrderSummaryViewDelegate> orderSummaryDelegate;

@end