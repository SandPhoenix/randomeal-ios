//
//  RMDBManager.m
//  randomeal
//
//  Created by Matteo Sandrin on 16/08/15.
//  Copyright © 2015 Matteo Sandrin. All rights reserved.
//

#define DEG2RAD(degrees) (degrees * 0.01745327)
#define maxDistance 20
#define maxLat 22.3593252
#define maxLon 114.1408686

#import "RMDBManager.h"

@implementation RMDBManager

@synthesize database,locationManager,location,districts,prices,kinds,currentShop;

+ (RMDBManager*)sharedManager {
    static RMDBManager *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

-(id) init{
    
    if (self == [super init]) {
        database = [self openDatabase];
        [self loadStrings];
        [self addDistanceFunc];
        [self startStandardUpdates];
        NSLog(@"hello");
    }
    
    return self;
}

- (FMDatabase *)openDatabase
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *documents_dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *db_path = [documents_dir stringByAppendingPathComponent:[NSString stringWithFormat:@"data.db"]];
    NSString *template_path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"db"];
    
    if (![fm fileExistsAtPath:db_path])
        [fm copyItemAtPath:template_path toPath:db_path error:nil];
    FMDatabase *db = [FMDatabase databaseWithPath:db_path];
    if (![db open])
        NSLog(@"Failed to open database!");
    return db;
}

-(void) addDistanceFunc{
    
    [database makeFunctionNamed:@"distance"
               maximumArguments:4
                      withBlock:^(sqlite3_context *context, int argc, sqlite3_value **argv)
    {

        assert(argc == 4);

        if (sqlite3_value_type(argv[0]) == SQLITE_NULL || sqlite3_value_type(argv[1]) == SQLITE_NULL || sqlite3_value_type(argv[2]) == SQLITE_NULL || sqlite3_value_type(argv[3]) == SQLITE_NULL) {
            sqlite3_result_null(context);
            return;
        }

        double lat1 = sqlite3_value_double(argv[0]);
        double lon1 = sqlite3_value_double(argv[1]);
        double lat2 = sqlite3_value_double(argv[2]);
        double lon2 = sqlite3_value_double(argv[3]);

        double lat1rad = DEG2RAD(lat1);
        double lat2rad = DEG2RAD(lat2);

        sqlite3_result_double(context, acos(sin(lat1rad) * sin(lat2rad) + cos(lat1rad) * cos(lat2rad) * cos(DEG2RAD(lon2) - DEG2RAD(lon1))) * 6378.1);
    }];
    
}


-(RMShop*) getShopWithinRadius:(NSNumber *)radius andPrice:(NSNumber *)price andKind:(NSArray *)kind{
    
    NSString *baseQuery = [NSString stringWithFormat:@"SELECT * FROM places WHERE distance(lat,long,%f,%f) <= %f ",location.coordinate.latitude,location.coordinate.longitude,[radius floatValue]];
    
    if (price != nil) {
        baseQuery = [baseQuery stringByAppendingString:[NSString stringWithFormat:@" AND price <= %d",[price intValue]]];
    }
    
    if (kind != nil) {
        if (kind.count > 0) {
            NSString *baseKindQuery = @" AND ( ";
            for (NSNumber *k in kind) {
                if ([kind indexOfObject:k] != kind.count - 1) {
                    baseKindQuery = [baseKindQuery stringByAppendingString:[NSString stringWithFormat:@"kind == %d OR ",k.intValue]];
                }else{
                    baseKindQuery = [baseKindQuery stringByAppendingString:[NSString stringWithFormat:@"kind == %d )",k.intValue]];
                }
                
               
                
            }
            baseQuery = [baseQuery stringByAppendingString:baseKindQuery];
        }
        
    }
    
    baseQuery = [baseQuery stringByAppendingString:@" ORDER BY rating DESC LIMIT 1"];
    
    NSLog(@"%@",baseQuery);
    
    FMResultSet *set = [database executeQuery:baseQuery];
    
    if ([set next]) {
        RMShop *shop = [[RMShop alloc] initWithResultSet:set];
        currentShop = shop;
        NSLog(@"%@",currentShop);
        return shop;
    }else{
        return nil;
    }
    
    
    
    
}

-(void) yelpTest{
    YPAPISample *y = [[YPAPISample alloc] init];
    [y queryTopBusinessInfoForTerm:@"italian" location:location completionHandler:^(NSDictionary *response, NSError *error){
        NSLog(@"%@",response);
    }];
}

#pragma Location handling

- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    [locationManager requestAlwaysAuthorization];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // Set a movement threshold for new events.
    locationManager.distanceFilter = 50; // meters
    
    [locationManager startUpdatingLocation];
//    [locationManager requestLocation];
    NSLog(@"starting location");
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    location = [locations lastObject];

    NSLog(@"latitude %+.6f, longitude %+.6f\n",
          location.coordinate.latitude,
          location.coordinate.longitude);
    
    Haversine *h = [[Haversine alloc] initWithLat1:location.coordinate.latitude lon1:location.coordinate.longitude lat2:maxLat lon2:maxLon];
    float distance = [h toKilometers];
    
    if (distance <= maxDistance) {
        self.isInsideArea = true;
    }else{
        self.isInsideArea = false;
    }
    
    NSLog(@"distance: %f",distance);
    
    
}



- (void) locationManager:(nonnull CLLocationManager *)manager didFailWithError:(nonnull NSError *)error{
    NSLog(@"location error: %@",error.localizedDescription);
}


#pragma strings

-(void) loadStrings{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"strings" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    districts = json[@"districts"];
    prices = json[@"prices"];
    kinds = json[@"kinds"];
    
    
}




@end
