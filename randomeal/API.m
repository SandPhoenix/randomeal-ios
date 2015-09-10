//
//  API.m
//  JackrabbitRefresh
//
//  Created by Matteo Sandrin on 26/05/15.
//  Copyright (c) 2015 Jackrabbit Mobile. All rights reserved.
//

#import "API.h"

@implementation API

@synthesize authParams;

+(API*)sharedAPI {
    static API *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

-(API*)init {
    //call super init
    self = [super init];
    if (self != nil) {
        
        

        
        authParams = @{ @"oauth_consumer_key": @"cMC83MTrtvLfZl5cIIMqyw",
                        @"oauth_token": @"BQt6iuyfjQTBvTDE7YV57jYCVPfne1v5",
                        @"oauth_signature_method" : @"hmac-sha1"
                        };
    }
    return self;
}

//AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:image_url]]];
//requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
//[requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//    NSLog(@"Response: %@", responseObject);
//    view.image = responseObject;
//    
//} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//    NSLog(@"Image error: %@", error);
//}];
//[requestOperation start];

#pragma Security


- (void) makeSecurityData{
    
    
}








@end
