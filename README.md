LocationAPI
===========

A simple class to get a location's coordinate using Google Maps API

Examples
--------

Find the coordinate for Cupertino

	[[LocationAPI sharedLocationAPI] coordinateForLocationNamed:@"Cupertino" callback:^(CLLocationCoordinate2D coordinate, NSError *error) {
		if (error) {
			[[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
			return;
		}

		NSLog(@"Coordinates: %f,%f", coordinate.latitude, coordinate.longitude);
	}];

Zoom to a specific location in a MKMapView

	[[LocationAPI sharedLocationAPI] coordinateForLocationNamed:self.locationName callback:^(CLLocationCoordinate2D coordinate, NSError *error) {
	    if (error) {
	        [[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
	        return;
	    }
    
	    MKCoordinateRegion zoomRegion = MKCoordinateRegionMakeWithDistance(coordinate, 2000, 2000);
	
		// self.mapView is a MKMapView in this ViewController's view
	    [self.mapView setRegion:zoomRegion animated:YES];
	}];

