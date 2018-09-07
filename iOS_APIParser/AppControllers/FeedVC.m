//
//  FeedVC.m
//  iOS_APIParser
//
//  Created by Dhruvik Rao on 9/7/18.
//  Copyright © 2018 Dhruvik Rao. All rights reserved.
//

#import "FeedVC.h"
#import "APIParser+User.h"
#import "APILogsVC.h"
#include <CommonCrypto/CommonDigest.h>

@interface CommentCell : UITableViewCell

@property (weak , nonatomic) IBOutlet UIImageView *imgProfileImage;
@property (weak , nonatomic) IBOutlet UILabel *lblName;
@property (weak , nonatomic) IBOutlet UILabel *lblEmail;
@property (weak , nonatomic) IBOutlet UILabel *lblCommentDesc;

@end

@implementation CommentCell

@synthesize imgProfileImage, lblName, lblEmail, lblCommentDesc;

@end


@interface FeedVC ()

@property (nonatomic, strong) NSMutableArray *commentArrayCount;

@end

@implementation FeedVC

- (void)viewDidLoad {
	
	[super viewDidLoad];
	[self getPostForUser:nil];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Sample web service calling

- (IBAction) getPostForUser :(id)sender {
	if (sender) { // To check API method stack
		[self getposts];
		[self getposts];
		[self getposts];
	} else {
		[self getposts];
	}
}


//Sample API
- (void)getposts {
	APIParser *service = [APIParser sharedMediaServer];
	
	[service URLRequestWithType:APIGetComments
					 parameters:nil
					cookieValue:nil
				  customeobject:nil
				withRequestType:APIRequestMethodGET
			 withRequestHeaders:nil
						  block:^(NSError *error, id objects, NSString *responseString, NSString *nextUrl, NSMutableArray *responseArray, NSURLResponse *URLResponseObject) {
							  
							  if (error) {
								  
								  //Handle Error
								  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[error domain] message:[NSString stringWithFormat:@"%@", error.localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
								  
								  UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
								  [alertController addAction:ok];
								  
								  [self presentViewController:alertController animated:YES completion:nil];
							  }
							  else {
								  
								  if (responseArray.count > 0) {
									  
									  //Handle Response Array
									  if (self.commentArrayCount == nil) {
										  self.commentArrayCount = [NSMutableArray new];
										  self.commentArrayCount = [responseArray mutableCopy];
									  } else {
										  [self.commentArrayCount addObjectsFromArray:[responseArray copy]];
									  }
									  
									  [self.tableView reloadData];
								  }
								  else {
									  
									  //Handle null response array
								  }
							  }
						  }];
}

#pragma mark - Login API
//Sample API
-(IBAction)loginUser:(id)sender {
	
	APIParser *service = [APIParser sharedMediaServer];
	
	NSDictionary *params = @{
							 @"uname":@"xyz@abc.com",
							 @"password":[self MD5HashFor:@"654321"]
							 };
	
	NSString *urlWithQuerystring = [service serializeParams:params];
	
	[service URLRequestWithType:APIUserLogIn
					 parameters:urlWithQuerystring
					cookieValue:nil
				  customeobject:nil
				withRequestType:APIRequestMethodPOST
			 withRequestHeaders:nil
						  block:^(NSError *error, id objects, NSString *responseString, NSString *nextUrl, NSMutableArray *responseArray, NSURLResponse *URLResponseObject) {
							  
							  if (error) {
								  
								  //Handle Error
								  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Failure!" message:[NSString stringWithFormat:@"%@", error.localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
								  
								  UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
								  [alertController addAction:ok];
								  
								  [self presentViewController:alertController animated:YES completion:nil];
							  }
							  else {
								  
								  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Success! Login Response" message:[NSString stringWithFormat:@"%@", objects] preferredStyle:UIAlertControllerStyleAlert];
								  
								  UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
								  [alertController addAction:ok];
								  
								  [self presentViewController:alertController animated:YES completion:nil];
							  }
						  }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.commentArrayCount.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	CommentCell *cell = (CommentCell *) [tableView dequeueReusableCellWithIdentifier:@"commentcell" forIndexPath:indexPath];
	
	cell.lblName.text = [(NSDictionary *)self.commentArrayCount[indexPath.row] valueForKey:@"name"];
	cell.lblEmail.text = [[(NSDictionary *)self.commentArrayCount[indexPath.row] valueForKey:@"email"] length] >= 20 ? [[(NSDictionary *)self.commentArrayCount[indexPath.row] valueForKey:@"email"] substringWithRange:NSMakeRange(0, 20)] : [(NSDictionary *)self.commentArrayCount[indexPath.row] valueForKey:@"email"];
	cell.lblCommentDesc.text = [(NSDictionary *)self.commentArrayCount[indexPath.row] valueForKey:@"body"];
	
	return cell;
}


-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Navigate to API logs

- (IBAction)navigateAPILog:(id)sender {
	APILogsVC *apiDetailVC = loadViewController(@"DeveloperInsights", @"idAPILogsVC");
	[self.navigationController pushViewController:apiDetailVC animated:YES];
}

- (NSString *) MD5HashFor:(NSString *)pass
{
	const char *cStr = [pass UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5( cStr, (int)strlen(cStr), result );
	return [NSString stringWithFormat:
			@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
			result[0], result[1], result[2], result[3],
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			];
}

@end
