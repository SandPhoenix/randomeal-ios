//
//  RMDBManager.h
//  randomeal
//
//  Created by Matteo Sandrin on 16/08/15.
//  Copyright © 2015 Matteo Sandrin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMShop.h"
#import <FMDB.h>
#import <CoreLocation/CoreLocation.h>
#import "Haversine.h"
#import "YPAPISample.h"

@interface RMDBManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic,strong) FMDatabase *database;
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) CLLocation *location;

@property (nonatomic,strong) NSArray *districts;
@property (nonatomic,strong) NSArray *prices;
@property (nonatomic,strong) NSDictionary *kinds;
@property (nonatomic) BOOL isInsideArea;
@property (nonatomic,strong) RMShop *currentShop;


+ (RMDBManager*) sharedManager;
- (void) getShopWithinRadius:(NSNumber*)radius completionHandler:(void (^)(RMShop *shop, NSError *error))completion;
-(void) yelpTest;


@end
