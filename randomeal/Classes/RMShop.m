//
//  RMShop.m
//  randomeal
//
//  Created by Matteo Sandrin on 15/08/15.
//  Copyright © 2015 Matteo Sandrin. All rights reserved.
//

#import "RMShop.h"

@implementation RMShop

@synthesize name,address,latitude,longitude,rating,image_url,url;

-(id) initWithResultSet:(NSDictionary *)dict{
    if (self == [super init]) {
            
        name = dict[@"name"];
        address = dict[@"location"][@"display_address"][0];
//            price = [set stringForColumn:@"price"];
        latitude = dict[@"location"][@"coordinate"][@"latitude"];
        longitude = dict[@"location"][@"coordinate"][@"longitude"];
//        kind = [NSNumber numberWithInt:[set intForColumn:@"kind"]];
//        district = [NSNumber numberWithInt:[set intForColumn:@"district"]];
        rating = dict[@"rating"];
        image_url = dict[@"image_url"];
        url = dict[@"url"];
        
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
