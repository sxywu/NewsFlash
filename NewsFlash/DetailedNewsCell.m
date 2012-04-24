//
//  DetailedNewsCell.m
//  NewsFlash
//
//  Created by Shirley Wu on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailedNewsCell.h"


@interface DetailedNewsCell()

//todo(Shirley): CHANGE THIS TO ARTICLE LATER.
@property (nonatomic, retain) IBOutlet UILabel *title;
@property (nonatomic, retain) IBOutlet UITextView *body;

@end


@implementation DetailedNewsCell

@synthesize title;
@synthesize body;

- (void)populateArticle:(NSDictionary *)article {
    title.text = [article objectForKey:@"title"];
    body.text = [article objectForKey:@"body"];
    
    CGRect frame = body.frame;
    frame.size.height = body.contentSize.height;
    body.frame = frame;
}

@end
