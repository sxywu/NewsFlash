//
//  DetailedNewsCell.h
//  NewsFlash
//
//  Created by Shirley Wu on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailedNewsCell : UITableViewCell

//todo(Shirley): change it to article later
- (void)populateArticle:(NSDictionary *)article;

@end
