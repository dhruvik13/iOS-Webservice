//
//  APILogsVC.h
//  iOS_APIParser
//
//  Created by Dhruvik Rao on 9/7/18.
//  Copyright © 2018 Dhruvik Rao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APIDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblStatusIndicator;
@property (weak, nonatomic) IBOutlet UILabel *lblAPITitle;
@property (weak, nonatomic) IBOutlet UILabel *lblAPIURL;
@property (weak, nonatomic) IBOutlet UIButton *btnStatusCode;

@end

@interface APILogsVC : UITableViewController

@end
