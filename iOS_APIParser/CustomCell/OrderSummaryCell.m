//
//  OrderSummaryCell.m
//  FastTicket
//
//  Created by Manan Sheth on 9/9/15.
//  Copyright (c) 2015 Sujav Group. All rights reserved.
//

#import "OrderSummaryCell.h"

@implementation OrderSummaryCell

@synthesize lblKey;
@synthesize lblValue;


- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
forCurrentObjectKey:(NSString*) key
forCurrentObjectValue:(NSString*) value
    forParentFrame : (CGRect) frame
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        int ParentWidth = CGRectGetWidth(frame);
        
        //Key
        lblKey = [UILabel new];
        lblKey.frame = CGRectMake(10, 8, (ParentWidth / 2) - 20, 20);
        
        CGRect textRectKey = [key boundingRectWithSize:CGSizeMake((ParentWidth / 2) - 20, 9999)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName:THEME_FONT_REGULAR(14.0)}
                                             context:nil];
        lblKey.frame = CGRectMake(10, 8, (ParentWidth / 2) - 20, textRectKey.size.height);
        
        lblKey.textColor = RGBCOLOR(131, 131, 131, 1);
        lblKey.textAlignment = NSTextAlignmentLeft;
        lblKey.font = THEME_FONT_REGULAR(14.0);
        lblKey.numberOfLines = 0;
        lblKey.text = key;
        [lblKey setBackgroundColor:[UIColor clearColor]];
        [self addSubview:lblKey];
        
        //Seperator
        UILabel *lblColumn = [UILabel new];
        lblColumn.frame = CGRectMake(CGRectGetMaxX(lblKey.frame) , lblKey.frame.origin.y - 4, 7, 24);
        [lblColumn setText:@" : "];
        lblColumn.numberOfLines = 0;
        lblColumn.font = THEME_FONT_REGULAR(14.0);
        lblColumn.textColor = RGBCOLOR(131, 131, 131, 1);
        lblColumn.textAlignment = NSTextAlignmentLeft;
        lblColumn.numberOfLines = 0;
        [lblColumn setBackgroundColor:[UIColor clearColor]];
        [self addSubview:lblColumn];
        
        //Value
        lblValue = [UILabel new];
        lblValue.frame = CGRectMake(CGRectGetMaxX(lblColumn.frame) + 4 , 8, ParentWidth - (CGRectGetMaxX(lblColumn.frame) + 10), 24);
        
        CGRect textRectValue = [value boundingRectWithSize:CGSizeMake(ParentWidth - (CGRectGetMaxX(lblColumn.frame) + 10), 9999)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName:THEME_FONT_REGULAR(14.0)}
                                               context:nil];
        
        lblValue.frame = CGRectMake(CGRectGetMaxX(lblColumn.frame) + 4 , 8, (ParentWidth - (CGRectGetMaxX(lblColumn.frame) + 10)), textRectValue.size.height);
        
        lblValue.textColor = RGBCOLOR(131, 131, 131, 1);
        lblValue.textAlignment = NSTextAlignmentLeft;
        lblValue.font = THEME_FONT_REGULAR(14.0);
        lblValue.numberOfLines = 0;
        lblValue.text = value;
        [lblValue setBackgroundColor:[UIColor clearColor]];
        [self addSubview:lblValue];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

@end
