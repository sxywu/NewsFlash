//
//  DetailedNewsCell.h
//  NewsFlash
//
//  Created by Shirley Wu on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Article;

@interface DetailedNewsCell : UITableViewCell

//todo(Shirley): change it to article later
- (void)populateArticle:(Article *)article;

@end
