//
//  TumblrReader.h
//  NewsFlash
//
//  Created by Shirley Wu on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTMOAuthAuthentication.h"
#import "SBJson.h"
#import "Article.h"

@interface TumblrUtility : NSObject

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;

- (id)init;
- (id)initContext:(NSManagedObjectContext*) context;
+ (GTMOAuthAuthentication *)myCustomAuth;
-(void) updateLinks;
-(void) like;

@end
