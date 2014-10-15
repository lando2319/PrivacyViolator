//
//  ViewController.m
//  NSAPrivacyViolator
//
//  Created by MIKE LAND on 10/15/14.
//  Copyright (c) 2014 MIKE LAND. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property CLLocationManager *myLocationManager;

@end

@implementation ViewController
- (IBAction)startViolatingPrivacy:(id)sender {
    [self.myLocationManager startUpdatingLocation];
    self.myTextView.text = @"Locating You...";
    NSLog(@"toast");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myLocationManager = [[CLLocationManager alloc] init];
    [self.myLocationManager requestWhenInUseAuthorization];
    self.myLocationManager.delegate = self;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"I failed: %@", error);
}


@end
