//
//  ViewController.m
//  LocationAPIExample
//
//  Created by Guilherme Rambo on 15/09/13.
//  Copyright (c) 2013 Guilherme Rambo. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

#import "LocationAPI.h"

@interface MapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewWillAppear:(BOOL)animated
{
    [[LocationAPI sharedLocationAPI] coordinateForLocationNamed:self.locationName callback:^(CLLocationCoordinate2D coordinate, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
            return;
        }
        
        NSLog(@"Coordinate: %f,%f", coordinate.latitude, coordinate.longitude);
        
        MKCoordinateRegion zoomRegion = MKCoordinateRegionMakeWithDistance(coordinate, 2000, 2000);
        [self.mapView setRegion:zoomRegion animated:YES];
    }];
}

@end
