//
//  MyLocation.h
//  MiniProjectGMK_iOS
//
//  Created by admin on 1/27/2559 BE.
//  Copyright (c) 2559 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyLocation : NSObject <MKAnnotation>

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;
- (MKMapItem*)mapItem;

@end