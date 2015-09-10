//
//  RMShop.m
//  randomeal
//
//  Created by Matteo Sandrin on 15/08/15.
//  Copyright © 2015 Matteo Sandrin. All rights reserved.
//

#import "RMShop.h"

@implementation RMShop

@synthesize name,address,price,latitude,longitude,kind,district,rating,image_url,url;

-(id) initWithResultSet:(FMResultSet *)set{
    if (self == [super init]) {
        do {
            
            name = [set stringForColumn:@"name"];
            address = [set stringForColumn:@"address"];
            price = [set stringForColumn:@"price"];
            latitude = [NSNumber numberWithDouble:[set doubleForColumn:@"lat"]];
            longitude = [NSNumber numberWithDouble:[set doubleForColumn:@"long"]];
            kind = [NSNumber numberWithInt:[set intForColumn:@"kind"]];
            district = [NSNumber numberWithInt:[set intForColumn:@"district"]];
            rating = [NSNumber numberWithDouble:[set doubleForColumn:@"rating"]];
            image_url = [set stringForColumn:@"image"];
            url = [set stringForColumn:@"url"];
            
        }while ([set next]);
    }
    return self;
}

-(void) loadThumbWithImageView:(UIImageView*)view{
    
    NSLog(@"image url: %@",image_url);
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:image_url]]];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@", responseObject);
        view.image = responseObject;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Image error: %@", error);
    }];
    [requestOperation start];
}

- (NSString*) description{
    return [NSString stringWithFormat:@"%@ - %@ - %@, %@",name,address,latitude,longitude];
}

@end
