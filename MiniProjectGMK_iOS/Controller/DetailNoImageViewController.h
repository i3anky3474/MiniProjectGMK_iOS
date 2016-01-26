//
//  DetailNoImageViewController.h
//  MiniProjectGMK_iOS
//
//  Created by admin on 1/27/2559 BE.
//  Copyright (c) 2559 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"

@interface DetailNoImageViewController : UIViewController
@property(nonatomic,weak) IBOutlet UILabel *lbTitle;
@property(nonatomic,weak) IBOutlet UITextView *tvDescription;
@property(nonatomic,strong) ArticleModel *articleModelClick;
-(IBAction)clickMap:(id)sender;
@end
