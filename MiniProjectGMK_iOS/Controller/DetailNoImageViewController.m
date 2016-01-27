//
//  DetailNoImageViewController.m
//  MiniProjectGMK_iOS
//
//  Created by admin on 1/27/2559 BE.
//  Copyright (c) 2559 admin. All rights reserved.
//

#import "DetailNoImageViewController.h"
#import "UIAlertView+Blocks.h"
#import "MBProgressHUD.h"
#import "ArticleModel.h"
#import "ServiceHelper.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"

@interface DetailNoImageViewController ()

@end

@implementation DetailNoImageViewController
@synthesize lbTitle;
@synthesize tvDescription;
@synthesize articleModelClick;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (SERVER_REACH != NotReachable) {
        //Load Banner
        //Show Dialog Loading
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:hud];
        hud.labelText = @"Loading...";
        [hud showAnimated:YES whileExecutingBlock:^{
            
            //Load List Article
            articleModelClick = [[ServiceHelper defaultController] getDetailArticleModel:articleModelClick.article_id];
            
        } completionBlock:^{
            [hud removeFromSuperview];
            
            //Set Label
            [lbTitle setText:articleModelClick.title];
            
            //Set Html TextView
            NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[articleModelClick.content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            tvDescription.attributedText = attributedString;
            //[tvDescription scrollRangeToVisible:NSMakeRange(0, 1)];
        }];
        
    }else{
        [[[UIAlertView alloc] initWithTitle:@""
                                    message:@"Please check your internet connection."
                           cancelButtonItem:[RIButtonItem itemWithLabel:@"OK" action:^{
            // Handle "Cancel"
        }]otherButtonItems:nil] show];
    }
}

-(void)viewWillAppear:(BOOL)animated
{

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

-(IBAction)clickMap:(id)sender
{
    NSLog(@"Click Map");
}

@end
