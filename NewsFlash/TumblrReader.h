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

@end
