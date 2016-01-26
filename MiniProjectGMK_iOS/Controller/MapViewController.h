//
//  MapViewController.h
//  MiniProjectGMK_iOS
//
//  Created by admin on 1/27/2559 BE.
//  Copyright (c) 2559 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ArticleModel.h"

@interface MapViewController : UIViewController<MKMapViewDelegate>
@property(nonatomic,weak) IBOutlet MKMapView *mapViewArticle;
@property(nonatomic,strong) ArticleModel *articleModelClick;
@end
