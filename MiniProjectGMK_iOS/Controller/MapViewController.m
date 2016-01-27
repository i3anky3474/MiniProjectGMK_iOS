//
//  MapViewController.m
//  MiniProjectGMK_iOS
//
//  Created by admin on 1/27/2559 BE.
//  Copyright (c) 2559 admin. All rights reserved.
//

#import "MapViewController.h"
#import "MyLocation.h"
#import "AddressAnnotation.h"

//@interface MapViewController ()
//@end

@interface MapViewController ()<CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation MapViewController
@synthesize mapViewArticle;
@synthesize articleModelClick;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //init Location Manager
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    //Init MapView
    self.mapViewArticle.delegate = self;
    self.mapViewArticle.mapType = MKMapTypeStandard;
    self.mapViewArticle.showsUserLocation = YES;
    
    //Set Article Value
    MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
    myAnnotation.coordinate = CLLocationCoordinate2DMake([articleModelClick.lat doubleValue], [articleModelClick.lon doubleValue]);
    myAnnotation.title = articleModelClick.type;
    myAnnotation.subtitle = articleModelClick.title;
    [self.mapViewArticle addAnnotation:myAnnotation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//#pragma mark - MKMapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        // Try to dequeue an existing pin view first.
        MKAnnotationView *pinView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            pinView.canShowCallout = YES;
            pinView.image = [UIImage imageNamed:@"red_icon.png"];
            pinView.calloutOffset = CGPointMake(0, 32);
            
            // Add a detail disclosure button to the callout.
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            pinView.rightCalloutAccessoryView = rightButton;
            
            // Add an image to the left callout.
            UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"red_icon.png"]];
            pinView.leftCalloutAccessoryView = iconView;
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
}

//#pragma mark Zoom
//- (IBAction)zoomToCurrentLocation:(UIBarButtonItem *)sender {
//    float spanX = 0.00725;
//    float spanY = 0.00725;
//    MKCoordinateRegion region;
//    region.center.latitude = mapViewArticle.userLocation.coordinate.latitude;
//    region.center.longitude = mapViewArticle.userLocation.coordinate.longitude;
//    region.span.latitudeDelta = spanX;
//    region.span.longitudeDelta = spanY;
//    [mapViewArticle setRegion:region animated:YES];
//}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
//    NSLog(@"didUpdateToLocation: %@", newLocation);
//    CLLocation *currentLocation = newLocation;
//    
//    if (currentLocation != nil) {
////        NSLog(@"Lat : %@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude]);
////        NSLog(@"Lon : %@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]);
//        
//        //Set Current Location
//        MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
//        myAnnotation.coordinate = CLLocationCoordinate2DMake([articleModelClick.lat doubleValue], [articleModelClick.lon doubleValue]);
//        myAnnotation.title = articleModelClick.type;
//        myAnnotation.subtitle = articleModelClick.title;
//        [self.mapViewArticle addAnnotation:myAnnotation];
//    }
}

@end
