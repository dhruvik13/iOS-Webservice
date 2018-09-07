//
//  APILogDetailVC.m
//  iOS_APIParser
//
//  Created by Dhruvik Rao on 9/7/18.
//  Copyright © 2018 Dhruvik Rao. All rights reserved.
//

#import "APILogDetailVC.h"

@interface APILogDetailVC ()
{
	__weak IBOutlet UILabel *lblRequestURL;
	__weak IBOutlet UILabel *lblRequestParameters;
	__weak IBOutlet UILabel *lblRequestHeaders;
	
	__weak IBOutlet UITextView *txtURLResponse;
	__weak IBOutlet UILabel *lblResponseHeader;
	
	__weak IBOutlet UISegmentedControl *responseDisplaySegmentControl;
}
@end

@implementation APILogDetailVC

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = [NSString stringWithFormat:@"%@ : Status (%ld) ",self.selectedAPIForDetail.APITitle, (long)((NSHTTPURLResponse *)self.selectedAPIForDetail.APIResponce).statusCode];
	
	lblRequestURL.text = self.selectedAPIForDetail.APIRequest.URL.absoluteString;
	lblRequestHeaders.text = [NSString stringWithFormat:@"%@",self.selectedAPIForDetail.APIRequest.allHTTPHeaderFields];
	lblRequestParameters.text = [[[NSString alloc] initWithData:[self.selectedAPIForDetail.APIRequest HTTPBody] encoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"&" withString:@"\n"];
	
	txtURLResponse.scrollEnabled = NO;
	
	//	txtURLResponse.text = (self.selectedAPIForDetail.responseDictionary) ? [NSString stringWithFormat:@"%@", self.selectedAPIForDetail.responseDictionary] : (self.selectedAPIForDetail.responseString.length>0) ? self.selectedAPIForDetail.responseString : @"";
	
	txtURLResponse.text = self.selectedAPIForDetail.responseString;
	
	[txtURLResponse layoutSubviews];
	
	[txtURLResponse resignFirstResponder];
	[txtURLResponse becomeFirstResponder];
	
	[self.tableView reloadData];
	
	[self.tableView beginUpdates];
	[self.tableView endUpdates];
	
	[responseDisplaySegmentControl addTarget:self
									  action:@selector(responseDisplaySegmentChanged:)
							forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return (section ==0) ? 3: 1;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 46;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return UITableViewAutomaticDimension;
}

#pragma mark - Response Display Segment changed

- (void)responseDisplaySegmentChanged:(id)sender {
	switch (responseDisplaySegmentControl.selectedSegmentIndex) {
		case 0: //RAW Response
		{
			txtURLResponse.text = self.selectedAPIForDetail.responseString;
		}
			break;
		case 1: //FORMATTED Response
		{
			txtURLResponse.text = [NSString stringWithFormat:@"%@", self.selectedAPIForDetail.responseDictionary];
		}
			break;
		default:
			break;
	}
	[self.tableView reloadData];
}

@end
