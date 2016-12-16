//
//  AppDelegate.m
//  NSTEasyJSON
//
//  Created by Timur Bernikowich on 12/15/16.
//  Copyright © 2016 Timur Bernikovich. All rights reserved.
//

#import "AppDelegate.h"

#import "NSTEasyJSON.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // TODO: Write convinient tests.
    
    NSDictionary *someDictionary = @{@"author":@"J.K. Rowling",
                                     @"books":@[@{@"title":@"Harry Potter and the Philosopher's Stone",
                                                  @"year":@(1997),
                                                  @"precededBy":[NSNull null]},
                                                @{@"title":@"Harry Potter and the Chamber of Secrets",
                                                  @"year":@(1998),
                                                  @"precededBy":@"Harry Potter and the Philosopher's Stone"}]};
    
    NSTEasyJSON *JSON = [NSTEasyJSON withObject:someDictionary];
    NSString *secondBookTitle = JSON[@"books"][0][@"title"].stringValue;
    NSString *firstBookPrecededBy = JSON[@"books"][0][@"precededBy"].string;
    
    return YES;
}

@end
