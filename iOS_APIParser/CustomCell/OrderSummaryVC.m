//
//  OrderSummaryVC.m
//  FastTicket
//
//  Created by Manan Sheth on 9/9/15.
//  Copyright (c) 2015 Sujav Group. All rights reserved.
//

#import "OrderSummaryVC.h"
#import "OrderSummaryCell.h"

@interface OrderSummaryVC () <UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView *tblOrder;
    
    IBOutlet UILabel *lblHeader;
    IBOutlet UIButton *btnClose;
}

- (IBAction)clickToClose:(id)sender;

@end

@implementation OrderSummaryVC

#pragma mark - Class Methods

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [lblHeader setFont:THEME_FONT_BOLD(15.0)];
    btnClose.titleLabel.font =THEME_FONT_BOLD(15.0);
    
    if (iPadDevice)
        [self.view setFrame:CGRectMake(100, 140, SCREEN_WIDTH - 200, SCREEN_HEIGHT - 280)];
//    else
//        [self.view setFrame:CGRectMake(10, 40, SCREEN_WIDTH - 20, SCREEN_HEIGHT - 80)];
    
    [tblOrder setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    tblOrder.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [tblOrder setBackgroundColor:[UIColor whiteColor]];
    
    [tblOrder reloadData];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getHeightForTransactionCellCellAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getOrderSummaryCellForRowAtIndexPath:indexPath];
}

- (CGFloat)getHeightForTransactionCellCellAtIndexPath:(NSIndexPath *)indexPath
{
    return ((UITableViewCell*)[self getOrderSummaryCellForRowAtIndexPath:indexPath]).contentView.frame.size.height;
}

- (UITableViewCell*)getOrderSummaryCellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    OrderSummaryCell *cell;
    
    NSString *reuseID = [NSString stringWithFormat:@"OrderSummaryCell%d", (int) indexPath.row];
    
    if (!cell)
    {
        cell = [[OrderSummaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID forCurrentObjectKey:[[PaymentSession currentPaymentSession].summaryDetailKeyArray objectAtIndex:indexPath.row] forCurrentObjectValue:[[PaymentSession currentPaymentSession].summaryDetailValueArray objectAtIndex:indexPath.row] forParentFrame:tblOrder.frame];
        
        float height = ((CGRectGetMaxY(cell.lblKey.frame) > CGRectGetMaxY(cell.lblValue.frame)) ? CGRectGetMaxY(cell.lblKey.frame) + 16 : CGRectGetMaxY(cell.lblValue.frame) + 16);
        
        cell.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH - 20, height);
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    return cell;
}

#pragma mark - Close View

- (IBAction)clickToClose:(id)sender
{
    [_orderSummaryDelegate clickForDismissView];
}

@end
