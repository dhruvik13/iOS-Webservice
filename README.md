# iOS-WebService

This will helps you to integrate API (web service) communication architecture within your project, without any third party tool required. Easy to implement in project.

## Usage

Here is a example of how to use this architecture to communicate with API server.

```objc
APIParser *service = [APIParser sharedMediaServer]; //set your shared Instanse for calling an API
	
	[service URLRequestWithType:APIGetComments      //specify your current calling API name
					 parameters:@""                 //pass request parameter as POST param orr GET param as per requirement
					cookieValue:nil                 //pass any cookie if required by the specific request 
				  customeobject:nil                 //pass any custom object as parameter if service required
				withRequestType:@"GET"              //define you request method
			 withRequestHeaders:nil                 //pass anny additional header parameters if required by the server or request
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
						  
