//
//  DetailedNewsScreen.m
//  NewsFlash
//
//  Created by Shirley Wu on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailedNewsScreen.h"
#import "DetailedNewsCell.h"


@interface DetailedNewsScreen ()

@property (retain, nonatomic) NSArray *articles;

@end


@implementation DetailedNewsScreen

@synthesize articles;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    articles = [NSArray arrayWithObjects: 
                [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"U.S., EU impose new sanctions on Syria blah", @"blahtotheblahblahtotheblahblahtotheblahblahtotheblahblahtotheblahblahtotheblahblahtotheblahblahtotheblahblahtotheblahblahtotheblahblahtotheblahblahtotheblahblahtotheblahblahblahtotheblahblahblahtotheblah", nil]
                                             forKeys:[NSArray arrayWithObjects:@"title", @"body", nil]], 
                [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"blah2", @"blahtotheblah2", nil]
                                            forKeys:[NSArray arrayWithObjects:@"title", @"body", nil]],
                [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"blah3", @"blahtotheblah3", nil]
                                            forKeys:[NSArray arrayWithObjects:@"title", @"body", nil]],
                nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [articles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailedNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailedNewsCell"];
    [cell populateArticle:[articles objectAtIndex:[indexPath section]]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        NSDate *date = [NSDate date];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"MMMM d, YYYY"];
        return [format stringFromDate:date];
    }
    return nil;
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellText = [[articles objectAtIndex:indexPath.section] objectForKey:@"body"];
    UIFont *cellFont = [UIFont fontWithName:@"System" size:14.0];
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
