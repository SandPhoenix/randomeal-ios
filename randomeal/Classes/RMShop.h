//
//  RMShop.h
//  randomeal
//
//  Created by Matteo Sandrin on 15/08/15.
//  Copyright © 2015 Matteo Sandrin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <FMDB.h>
#import <AFNetworking.h>

@interface RMShop : NSObject

@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * address;
@property (nonatomic,strong) NSString * price;
@property (nonatomic,strong) NSNumber * latitude;
@property (nonatomic,strong) NSNumber * longitude;
@property (nonatomic,strong) NSNumber * kind;
@property (nonatomic,strong) NSNumber * district;
@property (nonatomic,strong) NSNumber * rating;
@property (nonatomic,strong) NSString * image_url;
@property (nonatomic,strong) NSString * url;


-(id) initWithResultSet:(FMResultSet*)set;
-(void) loadThumbWithImageView:(UIImageView*)view;

@end
