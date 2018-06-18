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
    NSLog(@"%@", secondBookTitle);
    
    NSString *firstBookPrecededBy = JSON[@"books"][0][@"precededBy"].string;
    NSLog(@"%@", firstBookPrecededBy);
    
    NSDictionary *dictionary = @{@"array":@[@{@"key":@"value"}]};
    NSTEasyJSON *JSONWithArray = [NSTEasyJSON withObject:dictionary];
    for (NSTEasyJSON *arrayItemJSON in JSONWithArray[@"array"].JSONArray) {
        NSString *value = arrayItemJSON[@"key"].string;
        NSLog(@"%@", value);
    }
    
    
    NSDictionary *dict = @{
                           @"bar": @123.213212,
                           @"foo": @"Hello",
                           @"array": @[ @"a", @"b" ],
                           @"dict" : @{ @"a": @1.123, @"b": @123 }
                           };
    
    //    NSError *error;
    //    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    //    NSTEasyJSON *JSON = [NSTEasyJSON withData:jsonData];
    
    NSTEasyJSON *JSON2 = [NSTEasyJSON withObject:dict];
    
    NSLog(@"forceToStringValue key: nil   -> %@", JSON2[@"nil"].forceToString);
    NSLog(@"forceToStringValue key: nil   -> %@", JSON2[@"nil"].forceToStringValue);
    NSLog(@"forceToStringValue key: bar   -> %@", JSON2[@"bar"].forceToStringValue);
    NSLog(@"forceToStringValue key: foo   -> %@", JSON2[@"foo"].forceToStringValue);
    NSLog(@"forceToStringValue key: array -> %@", JSON2[@"array"].forceToStringValue);
    NSLog(@"forceToStringValue key: dict  -> %@", JSON2[@"dict"].forceToStringValue);
    
    NSLog(@"object key: bar   -> %@", JSON2.object);
    NSLog(@"object key: bar   -> %@", JSON2[@"bar"].object);
    NSLog(@"object key: foo   -> %@", JSON2[@"foo"].object);
    NSLog(@"object key: array -> %@", JSON2[@"array"].object);
    NSLog(@"object key: dict  -> %@", JSON2[@"dict"].object);
    
    return YES;
}

@end
