//
//  ServiceHelper.h
//  MiniProjectGMK_iOS
//
//  Created by Admin on 1/26/2559 BE.
//  Copyright (c) 2559 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleModel.h"

@interface ServiceHelper : NSObject

+(ServiceHelper *)defaultController;

-(NSString *)getStringFromURL:(NSString *)url;

//Service Call
-(NSMutableArray *)getListArticleModel;
-(ArticleModel *)getDetailArticleModel:(NSString *)acticle_id;

@end
