//
//  RMShop.m
//  randomeal
//
//  Created by Matteo Sandrin on 15/08/15.
//  Copyright © 2015 Matteo Sandrin. All rights reserved.
//

#import "RMShop.h"

@implementation RMShop

//@synthesize name,address,latitude,longitude,rating,image_url,url;

-(id) initWithResultSet:(NSDictionary *)dict{
    if (self == [super init]) {
        
        NSLog(@"%@",dict);
        self.name = (NSString*)dict[@"name"];
        self.address = [NSString stringWithFormat:@"%@\n%@",dict[@"location"][@"display_address"][0],dict[@"location"][@"display_address"][1]];
//            price = [set stringForColumn:@"price"];
        self.latitude = (NSNumber*)dict[@"location"][@"coordinate"][@"latitude"];
        self.longitude = (NSNumber*)dict[@"location"][@"coordinate"][@"longitude"];
//        kind = [NSNumber numberWithInt:[set intForColumn:@"kind"]];
//        district = [NSNumber numberWithInt:[set intForColumn:@"district"]];
        self.rating = (NSNumber*)dict[@"rating"];
        self.image_url = (NSString*)dict[@"image_url"];
        self.url = (NSString*)dict[@"url"];
        self.phone = (NSNumber*)dict[@"phone"];
        
    }
    return self;
}

-(void) loadThumbWithImageView:(UIImageView*)view{
    
    NSLog(@"image url: %@",self.image_url);
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.image_url]]];
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
    return [NSString stringWithFormat:@"%@ - %@ ",self.address,self.name];
}

@end
