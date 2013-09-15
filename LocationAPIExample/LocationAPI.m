//
//  LocationAPI.m
//  MapFun
//
//  Created by Guilherme Rambo on 15/09/13.
//  Copyright (c) 2013 Guilherme Rambo. All rights reserved.
//

#import "LocationAPI.h"

#define kAPIURLFormat @"http://maps.google.com/maps/api/geocode/json?address=%@&sensor=false"

@implementation LocationAPI

+ (LocationAPI *)sharedLocationAPI
{
    static LocationAPI *_shared;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[LocationAPI alloc] init];
    });
    
    return _shared;
}

- (void)coordinatesForLocationNamed:(NSString *)locationName callback:(void(^)(CLLocationCoordinate2D coordinates, NSError *error))callback
{
    NSString *urlString = [NSString stringWithFormat:kAPIURLFormat, [locationName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            callback(CLLocationCoordinate2DMake(0, 0), connectionError);
            return;
        }
        
        NSError *jsonError;
        NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        if (jsonError) {
            callback(CLLocationCoordinate2DMake(0, 0), jsonError);
            return;
        }
        
        // the API will return a status different from "OK" if, for instance, the location is not found
        if (![results[@"status"] isEqualToString:@"OK"]) {
            callback(CLLocationCoordinate2DMake(0, 0), [NSError errorWithDomain:@"locationAPI" code:0 userInfo:@{NSLocalizedDescriptionKey : NSLocalizedString(@"Location Not Found", @"Location Not Found")}]);
            return;
        }
        
        NSDictionary *locationDict = results[@"results"][0][@"geometry"][@"location"];
        CLLocationDegrees lat = [locationDict[@"lat"] doubleValue];
        CLLocationDegrees lng = [locationDict[@"lng"] doubleValue];
        
        callback(CLLocationCoordinate2DMake(lat, lng), nil);
    }];
}

@end
