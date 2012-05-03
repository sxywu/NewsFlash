//
//  TumblrReader.h
//  NewsFlash
//
//  Created by Shirley Wu on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJson.h"
#import "Article.h"

@interface TumblrReader : NSObject

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;

- (id)init;
- (id)initContext:(NSManagedObjectContext*) context;
-(void) updateLinks;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end
