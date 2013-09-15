LocationAPI
===========

A simple class to get a location's coordinates using Google Maps API

Examples
--------

Find the coordinates for Cupertino

	[[LocationAPI sharedLocationAPI] coordinatesForLocationNamed:@"Cupertino" callback:^(CLLocationCoordinate2D coordinates, NSError *error) {
		if (error) {
			[[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
			return;
		}

		NSLog(@"Coordinates: %f,%f", coordinates.latitude, coordinates.longitude);
	}];

Zoom to a specific location in a MKMapView

	[[LocationAPI sharedLocationAPI] coordinatesForLocationNamed:self.locationName callback:^(CLLocationCoordinate2D coordinates, NSError *error) {
	    if (error) {
	        [[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
	        return;
	    }
    
	    MKCoordinateRegion zoomRegion = MKCoordinateRegionMakeWithDistance(coordinates, 2000, 2000);
	
		// self.mapView is a MKMapView in this ViewController's view
	    [self.mapView setRegion:zoomRegion animated:YES];
	}];

