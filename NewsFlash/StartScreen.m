//
//  NavigationScreen.m
//  NewsFlash
//
//  Created by Shirley Wu on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StartScreen.h"
#import "DetailedNewsScreen.h"

@interface StartScreen ()

@end

@implementation StartScreen
@synthesize startButton;

- (void)dealloc {
    [startButton release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self signInToCustomService];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

- (void)signInToCustomService {
    
    //[self logout];
    
    
    
    NSURL *requestURL = [NSURL URLWithString:@"http://www.tumblr.com/oauth/request_token"];
    NSURL *accessURL = [NSURL URLWithString:@"http://www.tumblr.com/oauth/access_token"];
    NSURL *authorizeURL = [NSURL URLWithString:@"http://www.tumblr.com/oauth/authorize"];
    NSString *scope = @"http://www.tumblr.com";
    
    GTMOAuthAuthentication *auth = [TumblrUtility myCustomAuth];
    
    if([GTMOAuthViewControllerTouch authorizeFromKeychainForName:@"Tumblr Auth" authentication:auth])
    {
        // Auth is ready...
        if([auth canAuthorize])
        {
            NSLog(@"Auth is ready");
        }
        [self like: auth];
        
        DetailedNewsScreen *detailedNewsScreen = [[DetailedNewsScreen alloc] init];
        [self.navigationController pushViewController:detailedNewsScreen animated:YES];
        // Switch to some other screen...
        
    }
    else{
    
    // set the callback URL to which the site should redirect, and for which
    // the OAuth controller should look to determine when sign-in has
    // finished or been canceled
    //
    // This URL does not need to be for an actual web page
    [auth setCallback:@"http://www.example.com/OAuthCallback"];
    
    // Display the autentication view
    GTMOAuthViewControllerTouch *viewController;
    viewController = [[[GTMOAuthViewControllerTouch alloc] initWithScope:scope
                                                                language:nil
                                                         requestTokenURL:requestURL
                                                       authorizeTokenURL:authorizeURL
                                                          accessTokenURL:accessURL
                                                          authentication:auth
                                                          appServiceName:@"Tumblr Auth"
                                                                delegate:self
                                                        finishedSelector:@selector(viewController:finishedWithAuth:error:)] autorelease];
    
    //[self.navigationController pushViewController:viewController animated:NO];
    [self presentViewController:viewController animated:YES completion:nil];
    }
}

-(void) logout
{
    [GTMOAuthViewControllerTouch removeParamsFromKeychainForName:@"Tumblr Auth"];
}

- (void)viewController:(GTMOAuthViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuthAuthentication *)auth
                 error:(NSError *)error {
    if (error != nil) {
        NSLog(@"Auth failed");
        NSLog(@"%@",error);
    } else {
        
        //Do stuff here...segue to next window? Need to pass the auth object around as well
        NSLog(@"Auth success");
        DetailedNewsScreen *detailedNewsScreen = [[DetailedNewsScreen alloc] init];
        [self like: auth];
        [self presentViewController:detailedNewsScreen animated:YES completion:nil];
        
    }
}

-(void) like:(GTMOAuthAuthentication *) auth
{
    NSString* post_id = @"22309387575";
    NSString* reblogkey = @"e3eHJGcX";
    
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://api.tumblr.com/v2/user/like"]];
    [req setHTTPMethod:@"POST"];
    [req setValue: @"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSString* post = [NSString stringWithFormat:@"id=%@&reblog_key=%@", post_id, reblogkey];
    NSData* data = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    [req setHTTPBody:data];
    
    GTMHTTPFetcher* fetcher = [GTMHTTPFetcher fetcherWithRequest:req];
    [fetcher setAuthorizer:auth];
    
    
    //NSMutableData* data = [NSMutableData dataWithData:[req HTTPBody]];
    
    
    
    NSLog(@"Attempt to like");
    
    //NSURLResponse* response;
    //NSError* error;
    
    [fetcher beginFetchWithCompletionHandler:^(NSData *rdata, NSError *error) {
        if(error != nil){
            
            NSLog(@"ERROR: %@", error);
        }
        else{
            NSDictionary *results = [[[[NSString alloc] initWithData: 
                                       rdata encoding:NSUTF8StringEncoding] autorelease] JSONValue]; 
            NSLog(@"POST Successful: #%@ @ %@", [results objectForKey: 
                                                 @"id"], [results objectForKey: @"created_at"]); 
        }
    }];
    
    
    
    //NSData* response_data = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
    //NSLog(@"Data: %@", response_data);
    

}

@end
