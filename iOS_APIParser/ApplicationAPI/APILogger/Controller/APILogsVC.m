//
//  APILogsVC.m
//  iOS_APIParser
//
//  Created by Dhruvik Rao on 9/7/18.
//  Copyright © 2018 Dhruvik Rao. All rights reserved.
//

#import "APILogsVC.h"
#import "AppCacheManagement.h"
#import "APIInfoObject.h"
#import "APILogDetailVC.h"
#import "APIParser.h"

@implementation APIDetailCell

@end


@interface APILogsVC ()

@property (nonatomic, strong) NSMutableArray *APIDetailArray;

@end

@implementation APILogsVC

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.tableView.showsVerticalScrollIndicator = false;
	
	self.title = @"API Logs";
	
	[[AppCacheManagement sharedCacheManager] getcachedataArrayFor_:kDeveloperDebugAPILog myMethod:^(BOOL status, NSMutableArray *retrivedArray) {
		
		if (retrivedArray != nil) {
			
			_APIDetailArray = [[[retrivedArray reverseObjectEnumerator] allObjects] mutableCopy];
			
			[self.tableView reloadData];
			
			[self.tableView beginUpdates];
			[self.tableView endUpdates];
		}
	}];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _APIDetailArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	APIDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"APICell" forIndexPath:indexPath];
	
	APIInfoObject *apiDetail = (APIInfoObject *) [_APIDetailArray objectAtIndex:indexPath.row];
	
	if (((NSHTTPURLResponse *)apiDetail.APIResponce).statusCode == 200) {
		cell.lblStatusIndicator.backgroundColor = RGBCOLOR(10, 168, 50, 1.0);
	} else {
		cell.lblStatusIndicator.backgroundColor = RGBCOLOR(255, 0, 28, 1.0);
	}
	
	[cell.btnStatusCode setTitle:[NSString stringWithFormat:@"%ld", (long)((NSHTTPURLResponse *)apiDetail.APIResponce).statusCode] forState:UIControlStateNormal];
	
	cell.lblAPITitle.text = apiDetail.APITitle;
	
	cell.lblAPIURL.text = apiDetail.APIRequest.URL.absoluteString;
	
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	APILogDetailVC *APIDetail = loadViewController(@"DeveloperInsights", @"idAPILogDetailVC");
	APIDetail.selectedAPIForDetail = (APIInfoObject *) [_APIDetailArray objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:APIDetail animated:YES];
}


@end
