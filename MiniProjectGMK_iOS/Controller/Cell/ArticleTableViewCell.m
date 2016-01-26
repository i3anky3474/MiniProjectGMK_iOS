//
//  ArticleTableViewCell.m
//  MiniProjectGMK_iOS
//
//  Created by Admin on 1/26/2559 BE.
//  Copyright (c) 2559 admin. All rights reserved.
//

#import "ArticleTableViewCell.h"

@implementation ArticleTableViewCell
@synthesize imvArticle;
@synthesize lbTitle;
@synthesize lbDetail;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
