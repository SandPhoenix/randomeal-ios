//
//  RMDetailViewController.h
//  randomeal
//
//  Created by Matteo Sandrin on 22/08/15.
//  Copyright © 2015 Matteo Sandrin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "colors.h"
#import "RMDBManager.h"
#import "RMShop.h"

@interface RMDetailViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,strong) RMShop *shop;

@end
