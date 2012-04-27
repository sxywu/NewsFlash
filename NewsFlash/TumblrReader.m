//
//  TumblrReader.m
//  NewsFlash
//
//  Created by Shirley Wu on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TumblrReader.h"

@implementation TumblrReader
NSString* URL = @"http://api.tumblr.com/v2/blog/mrjnewsflash.tumblr.com/posts/link?api_key=wogRM0JCsWpW2z9p2rThvcsK4oh8fwJnWydYqxlPag7ep8tfm4";
NSMutableData* receivedData;

- (id)init {
    self = [super init];
    if (self) {
        // Initialize self.
    }
    return self;
}

-(void) updateLinks
{
    // Mmake async URL request
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if (theConnection) {
        
        receivedData = [[NSMutableData data] retain];
    } else {
        // RUH ROH connection failed, do something about this later
    }
    // Get JSON response and parse for results
    // Update results in data structure
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // release the connection, and the data object
    [connection release];
    // receivedData is declared as a method instance elsewhere
    [receivedData release];
    
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere

    
    NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
        
    SBJsonParser* parser = [[SBJsonParser alloc] init];
    NSDictionary* dict = [parser objectWithData:receivedData];
    
    // Need body, image, date, title, URL
    // NSString* msg = [[dict objectForKey:@"meta"] objectForKey:@"msg"];
    NSArray* posts = [[dict objectForKey:@"response"] objectForKey:@"posts"];
    
    for(NSDictionary* post in posts){
        NSString* body = [post objectForKey:@"description"];
        NSString* title = [post objectForKey:@"title"];
        NSString* url = [post objectForKey:@"url"];
        NSString* timestamp = [post objectForKey:@"timestamp"];
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]];
        
        
        //Strip the HTML tags
        NSRange r;
        while ((r = [body rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
            body = [body stringByReplacingCharactersInRange:r withString:@""];
        
        NSLog(@"Body: %@", body);
        NSLog(@"Title: %@", title);
        NSLog(@"Url: %@", url);
        NSLog(@"%@", date);
    }
    
    // release the connection, and the data object
    [connection release];
    [receivedData release];
    [parser release];
}



@end
