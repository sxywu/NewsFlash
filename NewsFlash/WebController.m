//
//  WebController.m
//  NewsFlash
//
//  Created by Shirley Wu on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebController.h"

@interface WebController ()

@property (nonatomic, retain) IBOutlet UIWebView *webView;

@end

@implementation WebController
@synthesize webView;

- (void)dealloc {
    [webView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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

- (void)setURLRequest:(NSURLRequest *)urlRequest{
    [webView loadRequest:urlRequest];
}

@end
