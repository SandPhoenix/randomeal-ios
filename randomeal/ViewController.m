//
//  ViewController.m
//  randomeal
//
//  Created by Matteo Sandrin on 15/08/15.
//  Copyright © 2015 Matteo Sandrin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize currentShop,manager,picker,radiusLabel;

-(void) viewDidAppear:(BOOL)animated{
    [super viewWillAppear:true];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [self updateSliderLabel];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    manager = [RMDBManager sharedManager];
    [self setupKinds];
//    [self performSegueWithIdentifier:@"pushToDetail" sender:self];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)restaurantButtonTapped:(id)sender {
    
//    NSNumber *radius = [NSNumber numberWithFloat:self.radiusSlider.value * 1500.0f + 500.0f];
//    NSNumber *price = [NSNumber numberWithInteger:self.priceSegmentedDisplay.selectedSegmentIndex];
//    
//    currentShop = [manager getShopWithinRadius:radius andPrice:price andKind:chosenKindArray];
//    if (currentShop) {
//        
//    }else{
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Our hamsters are tired." message:@"It seems like our hamsters didn't find anything... better luck next time!" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
//        [alert show];
//    }
    
    [manager yelpTest];
    
    
}

- (IBAction)chooseButtonTapped:(id)sender {
    
    [picker show];
    
}

- (void) setupUI{
    
    [self.view setBackgroundColor:UIColorFromHEX(BACKGROUND_COLOR)];
 
    self.foodButton.buttonColor = UIColorFromHEX(BUTTON_COLOR);
    self.foodButton.shadowColor = UIColorFromHEX(SHADOW_COLOR);
    self.foodButton.shadowHeight = 5.0f;
    self.foodButton.cornerRadius = 20.0;
    self.foodButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.foodButton.titleLabel.font = [UIFont boldFlatFontOfSize:55];
    [self.foodButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.foodButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    self.chooseButton.buttonColor = UIColorFromHEX(BUTTON_COLOR);
    self.chooseButton.shadowColor = UIColorFromHEX(SHADOW_COLOR);
    self.chooseButton.shadowHeight = 5.0f;
    self.chooseButton.cornerRadius = 20.0;
    self.chooseButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.chooseButton.titleLabel.font = [UIFont boldFlatFontOfSize:30];
    [self.chooseButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.chooseButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    [self.radiusSlider configureFlatSliderWithTrackColor:UIColorFromHEX(THIRD_COLOR)
                                     progressColor:UIColorFromHEX(SHADOW_COLOR)
                                        thumbColor:UIColorFromHEX(BUTTON_COLOR)];
    
    self.priceSegmentedDisplay.selectedFont = [UIFont boldFlatFontOfSize:10];
    self.priceSegmentedDisplay.selectedFontColor = [UIColor cloudsColor];
    self.priceSegmentedDisplay.deselectedFont = [UIFont flatFontOfSize:9];
    self.priceSegmentedDisplay.deselectedFontColor = [UIColor cloudsColor];
    self.priceSegmentedDisplay.selectedColor = UIColorFromHEX(BUTTON_COLOR);
    self.priceSegmentedDisplay.deselectedColor = UIColorFromHEX(SHADOW_COLOR);
    self.priceSegmentedDisplay.disabledColor = [UIColor silverColor];
    self.priceSegmentedDisplay.dividerColor = UIColorFromHEX(BACKGROUND_COLOR);
    self.priceSegmentedDisplay.cornerRadius = 20.0;
    
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:UIColorFromHEX(BUTTON_COLOR)];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor cloudsColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    picker = [[CZPickerView alloc] initWithHeaderTitle:@"Foods"
                                                   cancelButtonTitle:@"Cancel"
                                                  confirmButtonTitle:@"Confirm"];
    picker.delegate = self;
    picker.dataSource = self;
    picker.allowMultipleSelection = true;
    
    radiusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 70, 20)];
    radiusLabel.textAlignment = NSTextAlignmentCenter;
    radiusLabel.textColor = [UIColor cloudsColor];
    [self.view addSubview:radiusLabel];
    [self.radiusSlider addTarget:self action:@selector(updateSliderLabel) forControlEvents:UIControlEventValueChanged];
    
    
}

-(void) updateSliderLabel{
    radiusLabel.text = [NSString stringWithFormat:@"%.1f Km",self.radiusSlider.value * 1.5f + 0.5f];

    [radiusLabel setFrame:CGRectMake(self.radiusSlider.frame.origin.x + 10 + (self.radiusSlider.frame.size.width-20)*self.radiusSlider.value-radiusLabel.frame.size.width/2, self.radiusSlider.frame.origin.y-30, 70, 20)];
    
}

-(void) setupKinds{
    
    kinds = manager.kinds;
    kindLabelArray = [NSMutableArray array];
    chosenKindArray = [NSMutableArray array];
    
    for (NSString *key1 in [kinds allKeys]) {
        
        NSArray *subKind = (NSArray*)kinds[key1];
        [kindLabelArray addObject:key1];
        
        for (NSDictionary *subDict in subKind) {
            
            [kindLabelArray addObject:[NSString stringWithFormat:@"\t%@",(NSString*)subDict[@"name"]]];
            
        }
    }
    
}



#pragma Picker View Delegate

- (void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemsAtRows:(NSArray *)rows{
    chosenKindArray = [NSMutableArray array];
    for (NSNumber *rowIndex in rows) {
        NSString *title = (NSString*)kindLabelArray[[rowIndex intValue]];
        title = [title stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        for (NSString *key1 in [kinds allKeys]) {
            for (NSDictionary *value in kinds[key1]) {
                if (([title isEqualToString:key1] || [title isEqualToString:value[@"name"]]) && ![chosenKindArray containsObject:value[@"code"]]) {
                    [chosenKindArray addObject:value[@"code"]];
                }
            }
        }
    }
    
}

- (void)czpickerViewDidClickCancelButton:(CZPickerView *)pickerView{
    
}

#pragma Picker View Data Source


- (NSInteger)numberOfRowsInPickerView:(CZPickerView *)pickerView{
    
    return kindLabelArray.count;
    
}


- (NSString *)czpickerView:(CZPickerView *)pickerView
               titleForRow:(NSInteger)row{
    
    return [kindLabelArray objectAtIndex:row];
    
}

@end
