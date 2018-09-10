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
				withRequestType:APIRequestMethodGET              //define you request method
			 withRequestHeaders:nil                 //pass anny additional header parameters if required by the server or request
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
						  

- Added support for NSINvocation
- Enhancement for CacheManagement
- Reachabilty support improved
- Debug logs for API calling 
- Connection Lost UI added (Image source Google)
- Call API from where connection lost (maintained with parameters)


To enanble API Logs
[[AppCacheManagement sharedCacheManager] setAPILoggingEnabled:true];

