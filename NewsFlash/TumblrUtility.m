//
//  TumblrReader.m
//  NewsFlash
//
//  Created by Shirley Wu on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TumblrUtility.h"

@implementation TumblrUtility


@synthesize managedObjectContext;

NSString* URL = @"http://api.tumblr.com/v2/blog/mrjnewsflash.tumblr.com/posts/link?api_key=wogRM0JCsWpW2z9p2rThvcsK4oh8fwJnWydYqxlPag7ep8tfm4";

NSString* consumerKey = @"wogRM0JCsWpW2z9p2rThvcsK4oh8fwJnWydYqxlPag7ep8tfm4";
NSString* secretKey = @"Krcd2FIq98ksD0mACvJiCOT84Erm7O7jaGwkXyZeGj5r0eHqJT";

NSData* receivedData;

- (id)init {
    self = [super init];
    if (self) {
        // Initialize self.
    }
    return self;
}

- (id)initContext:(NSManagedObjectContext*) context {
    self = [super init];
    if (self) {
        managedObjectContext = context;
    }
    return self;
}

+ (GTMOAuthAuthentication *)myCustomAuth {
    
    GTMOAuthAuthentication *auth;
    auth = [[[GTMOAuthAuthentication alloc] initWithSignatureMethod:kGTMOAuthSignatureMethodHMAC_SHA1
                                                        consumerKey:consumerKey
                                                         privateKey:secretKey] autorelease];
    
    // setting the service name lets us inspect the auth object later to know
    // what service it is for
    auth.serviceProvider = @"Tumblr Auth";
    
    return auth;
}


-(void) like
{
    
}

-(void) updateLinks
{
    NSURLResponse* response;
    NSError* error;
    // Make sync URL request
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    //NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    receivedData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
    
    
    SBJsonParser* parser = [[SBJsonParser alloc] init];
    NSDictionary* dict = [parser objectWithData:receivedData];
    
    // Need body, image, date, title, URL
    // NSString* msg = [[dict objectForKey:@"meta"] objectForKey:@"msg"];
    NSArray* posts = [[dict objectForKey:@"response"] objectForKey:@"posts"];
    
    // FetchRequest to make sure that no old articles are rewritten into CoreData
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Article"
                                        inManagedObjectContext:managedObjectContext]];
    
    for(NSDictionary* post in posts){
        
        //Grab the relevant attributes...
        NSString* body = [post objectForKey:@"description"];
        NSString* title = [post objectForKey:@"title"];
        NSString* url = [post objectForKey:@"url"];
        NSString* post_id = [NSString stringWithFormat: @"%d",[post objectForKey:@"id"]];
        NSString* reblogkey = [post objectForKey:@"reblog_key"];
        
        // Timestamp seems to be in UNIX time since 1970
        NSString* timestamp = [post objectForKey:@"timestamp"];
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]];
        
        //Predicate for if post already in CoreData
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"date == %@", date]];
        
        if ([managedObjectContext countForFetchRequest:fetchRequest error:&error]) {
            break;
        } else {
            //Strip the HTML tags
            NSRange r;
            while ((r = [body rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
                body = [body stringByReplacingCharactersInRange:r withString:@""];
            
            
            NSManagedObjectContext *context = [self managedObjectContext];
            Article* article = [NSEntityDescription insertNewObjectForEntityForName:@"Article" inManagedObjectContext:context];
            
            
            article.body = body;
            article.title = title;
            article.url = url;
            article.date = date;
            article.post_id = post_id;
            article.reblogkey = reblogkey;
            
            NSError *error;
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            
            
            NSLog(@"Body: %@", body);
            NSLog(@"Title: %@", title);
            NSLog(@"Url: %@", url);
            NSLog(@"%@", date);
        }
        
    }

    [parser release];
    [fetchRequest release];
    NSLog(@"Tumblr Reader");
    /*
    if (theConnection) {
        
        receivedData = [[NSMutableData data] retain];
    } else {
        // RUH ROH connection failed, do something about this later
    }*/
    // Get JSON response and parse for results
    // Update results in data structure
    
}



@end
