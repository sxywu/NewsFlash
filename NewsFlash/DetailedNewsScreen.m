//
//  DetailedNewsScreen.m
//  NewsFlash
//
//  Created by Shirley Wu on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Article.h"
#import "AppDelegate.h"
#import "DetailedNewsScreen.h"
#import "DetailedNewsCell.h"


@interface DetailedNewsScreen ()

@property (nonatomic, retain) NSFetchedResultsController *fetchResultsController;
@property (nonatomic,readonly) NSManagedObjectContext* managedObjectContext;
//@property (retain, nonatomic) NSArray *articles;

@end


@implementation DetailedNewsScreen

//@synthesize articles;
@synthesize managedObjectContext;
@synthesize fetchResultsController;

- (void)dealloc {
    fetchResultsController.delegate = nil;
//    [articles release];
    [managedObjectContext release];
    [fetchResultsController release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    fetchResultsController = [self newFetchResultsController];
    NSError *error = nil;
    if (![fetchResultsController performFetch:&error]) {
        NSLog(@"Error fetching core data");
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


#pragma mark - accessors

- (NSManagedObjectContext *)managedObjectContext {
    if (managedObjectContext == nil) {
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        managedObjectContext = [appDelegate.managedObjectContext retain];
    }
    return managedObjectContext;
}

- (NSFetchedResultsController *)newFetchResultsController {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Article"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSDate* today = [NSDate date];
    
    // Offset of one day in seconds
    NSDate *yesterday = [today dateByAddingTimeInterval: -86400.0];
    
    // Get all articles within the span of one day
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(date >= %@)", yesterday];
    [fetchRequest setPredicate:predicate];

    
    [sortDescriptor release];
    [sortDescriptors release];
    
    NSFetchedResultsController *controller = [[NSFetchedResultsController alloc]
                                              initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    [fetchRequest release];
    
    return controller;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSUInteger sections = [[[fetchResultsController sections] objectAtIndex:0] numberOfObjects];
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailedNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailedNewsCell"];
    NSUInteger indexes[] = {0, indexPath.section};
    NSIndexPath *path = [NSIndexPath indexPathWithIndexes:indexes length:2];
    Article *article = (Article *)[fetchResultsController objectAtIndexPath:path];
    [cell populateArticle:article];
    NSLog(@"Cell populated");
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
