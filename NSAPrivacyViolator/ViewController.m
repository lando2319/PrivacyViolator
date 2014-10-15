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


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    for (CLLocation *location in locations) {
        if (location.verticalAccuracy < 1000 && location.horizontalAccuracy < 1000) {
            self.myTextView.text = @"Location Found. Reverse Geocoding...";
            [self reverseGeocoding:location];
            NSLog(@"%@", location);
            [self.myLocationManager stopUpdatingLocation];
            break;
        }
    }
}

- (void)reverseGeocoding:(CLLocation *)location{
    CLGeocoder *geocoder = [CLGeocoder new];

    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = placemarks.firstObject;
        NSString *address = [NSString stringWithFormat:@"%@ %@ \n%@",
                             placemark.subThoroughfare,
                             placemark.thoroughfare,
                             placemark.locality];
        self.myTextView.text = [NSString stringWithFormat:@"Found you: %@", address];
        [self findJaiNear:placemark.location];
    }];
}

- (void)findJaiNear:(CLLocation *)location{

}






@end
