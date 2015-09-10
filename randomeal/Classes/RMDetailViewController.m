    //
//  RMDetailViewController.m
//  randomeal
//
//  Created by Matteo Sandrin on 22/08/15.
//  Copyright © 2015 Matteo Sandrin. All rights reserved.
//

#import "RMDetailViewController.h"

@implementation RMDetailViewController
@synthesize shop;

-(void) viewDidLoad{
    [super viewDidLoad];
    shop = [[RMDBManager sharedManager] currentShop];
//    [self setupMaps];
    
    self.view.backgroundColor = UIColorFromHEX(BACKGROUND_COLOR);
    
    
}

-(void) setupMaps{
    
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    self.mapView.layer.cornerRadius = 15.0f;
    self.mapView.layer.shadowRadius = 10;
    self.mapView.layer.shadowOpacity = 0.2;
    self.mapView.layer.shadowOffset = CGSizeMake(1, 1);

    
    NSLog(@"%@",shop);
    CLLocationCoordinate2D  point;
    point.latitude = [self.shop.latitude floatValue];
    point.longitude = [self.shop.longitude floatValue];
    self.mapView.centerCoordinate = point;
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:point];
    [annotation setTitle:shop.name];
    [self.mapView addAnnotation:annotation];
}

@end
