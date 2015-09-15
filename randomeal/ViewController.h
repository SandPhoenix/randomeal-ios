//
//  ViewController.h
//  randomeal
//
//  Created by Matteo Sandrin on 15/08/15.
//  Copyright © 2015 Matteo Sandrin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Classes/RMDBManager.h"
#import "Classes/RMShop.h"
#import "FlatUIKit.h"
#import "colors.h"
#import "CZPicker.h"

@interface ViewController : UIViewController <CZPickerViewDataSource,CZPickerViewDelegate>

{
    NSDictionary *kinds;
    NSMutableArray *kindLabelArray;
    NSMutableArray *chosenKindArray;
}


@property (weak, nonatomic) IBOutlet FUISegmentedControl *priceSegmentedDisplay;
@property (weak, nonatomic) IBOutlet UISlider *radiusSlider;
@property (nonatomic,strong) RMShop *currentShop;
@property (nonatomic,strong) RMDBManager *manager;
@property (weak, nonatomic) IBOutlet UIButton *foodButton;
@property (nonatomic,strong) CZPickerView *picker;
@property (weak, nonatomic) IBOutlet FUIButton *chooseButton;
@property (strong,nonatomic) UILabel *radiusLabel;



- (IBAction)restaurantButtonTapped:(id)sender;
- (IBAction)chooseButtonTapped:(id)sender;

@end

