//
//  TableVC.m
//  iOS_APIParser
//
//  Created by Dhruvik Rao on 2/6/17.
//  Copyright © 2017 Dhruvik Rao. All rights reserved.
//

#import "TableVC.h"

#import "APIParser+User.h"


@interface CommentCell : UITableViewCell

@property (weak , nonatomic) IBOutlet UIImageView *imgProfileImage;
@property (weak , nonatomic) IBOutlet UILabel *lblName;
@property (weak , nonatomic) IBOutlet UILabel *lblEmail;
@property (weak , nonatomic) IBOutlet UILabel *lblCommentDesc;

@end

@implementation CommentCell

@synthesize imgProfileImage, lblName, lblEmail, lblCommentDesc;

@end


@interface TableVC ()

@property (nonatomic, strong) NSMutableArray *commentArrayCount;

@end

@implementation TableVC

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self getPostForUser:nil];
}

#pragma mark - Sample web service calling

- (IBAction) getPostForUser :(id)sender {
	
	APIParser *service = [APIParser sharedMediaServer];
	
	[service URLRequestWithType:APIGetComments
					 parameters:@""
					cookieValue:nil
				  customeobject:nil
				withRequestType:@"GET"
			 withRequestHeaders:nil
						  block:^(NSError *error, id objects, NSString *responseString, NSString *nextUrl, NSMutableArray *responseArray, NSURLResponse *URLResponseObject) {
							  
							  if (error) {
								  
								  //Handle Error
							  }
							  else {
								  
								  if (responseArray.count > 0) {
									  
									  //Handle Response Array
									  self.commentArrayCount = [NSMutableArray new];
									  self.commentArrayCount = responseArray;
									  
									  [self.tableView reloadData];
								  }
								  else {
									  
									  //Handle null response array
								  }
							  }
						  }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
