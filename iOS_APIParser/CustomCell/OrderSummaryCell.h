//
//  OrderSummaryCell.h
//  FastTicket
//
//  Created by Manan Sheth on 9/9/15.
//  Copyright (c) 2015 Sujav Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderSummaryCell : UITableViewCell

@property (strong, nonatomic) UILabel *lblKey;
@property (strong, nonatomic) UILabel *lblValue;

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
    forCurrentObjectKey:(NSString*) key
    forCurrentObjectValue:(NSString*) value
    forParentFrame : (CGRect) frame ;

@end
