//
//  LocationAPI.h
//  MapFun
//
//  Created by Guilherme Rambo on 15/09/13.
//  Copyright (c) 2013 Guilherme Rambo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LocationAPI : NSObject

/*
 Returns a shared LocationAPI instance
 */
+ (LocationAPI *)sharedLocationAPI;

/*
 Calls "callback" with a CLLocationCoordinate2D struct containing the latitude and logitude of the location
 
 Example:
 [[LocationAPI sharedLocationAPI] coordinatesForLocationNamed:@"Cupertino" callback:^(CLLocationCoordinate2D coordinates, NSError *error) {
 if (error) {
 [[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
 return;
 }
 
 NSLog(@"Coordinates: %f,%f", coordinates.latitude, coordinates.longitude);
 }];
 */
- (void)coordinatesForLocationNamed:(NSString *)locationName callback:(void(^)(CLLocationCoordinate2D coordinates, NSError *error))callback;

@end
