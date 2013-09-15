//
//  SetLocationViewController.m
//  LocationAPIExample
//
//  Created by Guilherme Rambo on 15/09/13.
//  Copyright (c) 2013 Guilherme Rambo. All rights reserved.
//

#import "SetLocationViewController.h"
#import "MapViewController.h"

@interface SetLocationViewController ()

@property (weak, nonatomic) IBOutlet UITextField *locationNameField;

@end

@implementation SetLocationViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.locationNameField.text = @"";
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.locationNameField becomeFirstResponder];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [segue.destinationViewController setLocationName:self.locationNameField.text];
}

- (IBAction)doneAction:(id)sender {
    [self performSegueWithIdentifier:@"showMap" sender:sender];
}

@end
