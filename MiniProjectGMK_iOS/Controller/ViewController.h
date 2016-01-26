//
//  ViewController.h
//  MiniProjectGMK_iOS
//
//  Created by admin on 1/26/2559 BE.
//  Copyright (c) 2559 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *arrayArticle;
}
@property(nonatomic,weak) IBOutlet UITableView *tableViewArticle;
@property(nonatomic,weak) IBOutlet UIBarButtonItem *buttonRefresh;
-(IBAction)clickRefresh:(id)sender;
@end

