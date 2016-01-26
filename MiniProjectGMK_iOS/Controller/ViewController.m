//
//  ViewController.m
//  MiniProjectGMK_iOS
//
//  Created by admin on 1/26/2559 BE.
//  Copyright (c) 2559 admin. All rights reserved.
//

#import "ViewController.h"
#import "ArticleModel.h"
#import "ServiceHelper.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
#import "ArticleTableViewCell.h"
#import "ArticleNoImageTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIAlertView+Blocks.h"
#import "DetailViewController.h"
#import "DetailNoImageViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize tableViewArticle;
@synthesize buttonRefresh;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Load List Article
    [self clickRefresh:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clickRefresh:(id)sender
{
    if (SERVER_REACH != NotReachable) {
        //Load Banner
        //Show Dialog Loading
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:hud];
        hud.labelText = @"Loading...";
        [hud showAnimated:YES whileExecutingBlock:^{
            
            //Load List Article
            arrayArticle = [[ServiceHelper defaultController] getListArticleModel];
            
        } completionBlock:^{
            [hud removeFromSuperview];
        
            //Reload Table
            //NSLog(@"Count : %d",[arrayArticle count]);
            [tableViewArticle reloadData];
        }];
        
    }else{
        [[[UIAlertView alloc] initWithTitle:@""
                                    message:@"Please check your internet connection."
                           cancelButtonItem:[RIButtonItem itemWithLabel:@"OK" action:^{
            // Handle "Cancel"
            [buttonRefresh setEnabled:YES];
        }]otherButtonItems:nil] show];
    }
}

#pragma mark - Table view delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return 10;
    return [arrayArticle count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Get Article Model
    ArticleModel *articleModel = [arrayArticle objectAtIndex:[indexPath row]];
    
    //Check Cell with Image
    if(articleModel.image.length != 0)
    {
        //Cell with Image
        static NSString *CellIdentifier = @"ArticleTableViewCell";
        // Configure the cell...
        ArticleTableViewCell  *articleTableViewCell = (ArticleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (articleTableViewCell == nil) {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ArticleTableViewCell" owner:self options:nil];
            for (id currentObject in topLevelObjects){
                if ([currentObject isKindOfClass:[UITableViewCell class]]){
                    articleTableViewCell = (ArticleTableViewCell *) currentObject;
                    break;
                }
            }
        }
        //Load Image
        [articleTableViewCell setContentMode:UIViewContentModeScaleAspectFit];
        NSString *urlStringFull = [NSString stringWithFormat:@"%@%@",URL_BASE,articleModel.image];
        [articleTableViewCell.imvArticle sd_setImageWithURL:[NSURL URLWithString:urlStringFull]
                                           placeholderImage:[UIImage imageNamed:@"white.png"]];
        //Set Text
        [articleTableViewCell.lbTitle setText:articleModel.title];
        [articleTableViewCell.lbDetail setText:articleModel.short_description];
        return articleTableViewCell;
    }
    else
    {
        //Cell with out Image
        static NSString *CellIdentifier = @"ArticleNoImageTableViewCell";
        // Configure the cell...
        ArticleNoImageTableViewCell  *articleNoImageTableViewCell = (ArticleNoImageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (articleNoImageTableViewCell == nil) {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ArticleNoImageTableViewCell" owner:self options:nil];
            for (id currentObject in topLevelObjects){
                if ([currentObject isKindOfClass:[UITableViewCell class]]){
                    articleNoImageTableViewCell = (ArticleNoImageTableViewCell *) currentObject;
                    break;
                }
            }
        }
        //Set Text
        [articleNoImageTableViewCell.lbTitle setText:articleModel.title];
        [articleNoImageTableViewCell.lbDetail setText:articleModel.short_description];
        return articleNoImageTableViewCell;
    }
}

-(void)back
{
    // Tell the controller to go back
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - Table view Click delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleModel *articleModel = [arrayArticle objectAtIndex:[indexPath row]];
    if(articleModel.image.length != 0)
    {
        //Call Detail View
        DetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
        detailViewController.articleModelClick = [arrayArticle objectAtIndex:[indexPath row]];
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    else
    {
        //Call Detail with out Image
        DetailNoImageViewController *detailNoImageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailNoImageViewController"];
        detailNoImageViewController.articleModelClick = [arrayArticle objectAtIndex:[indexPath row]];
        [self.navigationController pushViewController:detailNoImageViewController animated:YES];
    }
}

@end
