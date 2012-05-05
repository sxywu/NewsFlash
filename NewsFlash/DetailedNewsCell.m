//
//  DetailedNewsCell.m
//  NewsFlash
//
//  Created by Shirley Wu on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Article.h"
#import "DetailedNewsCell.h"
#import "GradientCellBackground.h"


@interface DetailedNewsCell()

//todo(Shirley): CHANGE THIS TO ARTICLE LATER.
@property (nonatomic, retain) IBOutlet UILabel *title;
@property (nonatomic, retain) IBOutlet UITextView *body;

@end


@implementation DetailedNewsCell

@synthesize title;
@synthesize body;

- (void)dealloc {
    [title release];
    [body release];
    [super dealloc];
}

- (void)populateArticle:(Article *)article {
    title.text = article.title;
    
    body.text = article.body;
    CGRect frame = body.frame;
    frame.size.height = body.contentSize.height;
    body.frame = frame;
    
    self.backgroundView = [[[GradientCellBackground alloc] init] autorelease];
    
    
}


@end
