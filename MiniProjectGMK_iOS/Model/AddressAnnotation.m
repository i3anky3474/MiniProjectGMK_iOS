//
//  AddressAnnotation.m
//  MiniProjectGMK_iOS
//
//  Created by admin on 1/27/2559 BE.
//  Copyright (c) 2559 admin. All rights reserved.
//

#import "AddressAnnotation.h"

@implementation AddressAnnotation
@synthesize coordinate;

- (NSString *)subtitle{
    return nil;
}

- (NSString *)title{
    return nil;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
    coordinate=c;
    return self;
}

@end