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
    [self setupMaps];
    
    self.view.backgroundColor = UIColorFromHEX(BACKGROUND_COLOR);
    [self setTitle:shop.name];
    
    [shop loadThumbWithImageView:self.thumbImageView];
    self.thumbImageView.layer.cornerRadius = 10.0f;
    self.thumbImageView.clipsToBounds = true;
    self.addressLabel.text = shop.address;
    self.addressLabel.numberOfLines = 0;
    self.addressLabel.textColor = [UIColor cloudsColor];
    [self.addressLabel setFont:[UIFont flatFontOfSize:28]];
    
    
    
    
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
    [annotation setTitle:[NSString stringWithFormat:@"%@ - %@",shop.name,shop.address]];
    

//    [self setupZoom];
    CLLocation *currentLocation = [[RMDBManager sharedManager] location];
    MKPointAnnotation *currentPosition = [[MKPointAnnotation alloc] init];
    [currentPosition setCoordinate:currentLocation.coordinate];
    
    [self.mapView showAnnotations:@[annotation,currentPosition] animated:true];
    [self.mapView removeAnnotation:currentPosition];
    [self.mapView selectAnnotation:annotation animated:true];

}

-(void) setupZoom{
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(zoomRect)) {
            zoomRect = pointRect;
        } else {
            zoomRect = MKMapRectUnion(zoomRect, pointRect);
        }
    }
    [self.mapView setVisibleMapRect:zoomRect edgePadding:UIEdgeInsetsMake(10, 10, 10, 10) animated:YES];
}

- (IBAction)dismissDetailView:(id)sender {
    
    [self dismissViewControllerAnimated:true completion:nil];
    
}
@end
