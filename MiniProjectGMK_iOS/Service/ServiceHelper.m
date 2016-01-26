//
//  ServiceHelper.m
//  MiniProjectGMK_iOS
//
//  Created by Admin on 1/26/2559 BE.
//  Copyright (c) 2559 admin. All rights reserved.
//

#import "ServiceHelper.h"
#import "ArticleModel.h"

@implementation ServiceHelper

static ServiceHelper * _sharedInstance = nil;

+(ServiceHelper *)defaultController{
    
    @synchronized([ServiceHelper class]) {
        if (!_sharedInstance)
            [[self alloc] init];
        return _sharedInstance;
    }
    
    return nil;
}

+(id)alloc {
    @synchronized([ServiceHelper class]) {
        NSAssert(_sharedInstance == nil, @"Attempted to allocate a second instance of a singleton.");
        _sharedInstance = [super alloc];
        return _sharedInstance;
    }
    
    return nil;
}

-(id)init {
    self = [super init];
    if (self != nil) {
        // initialize stuff here
    }
    return self;
}

//Load String from URL
-(NSString *)getStringFromURL:(NSString *)url
{
    //Get Banner icon
    NSString *urlX = [url stringByReplacingOccurrencesOfString:@"|" withString:@"%7C"];
    NSURL *urly = [NSURL URLWithString:urlX];
    NSData *nsDatay = [[NSData alloc]initWithContentsOfURL:urly];
    NSString* contentData = [[NSString alloc] initWithData:nsDatay encoding:NSUTF8StringEncoding];
    return contentData;
}

-(NSMutableArray *)getListArticleModel
{
    NSMutableArray *arrayObject = [[NSMutableArray alloc]init];
    NSString *content = [self getStringFromURL:URL_GetListArticles];
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
    NSDictionary *jsonStatus = [jsonDic objectForKey:@"status"];
    NSString *code = [jsonStatus objectForKey:@"code"];
    if([code isEqualToString:@"200"])
    {
        if([jsonDic objectForKey:@"data"])
        {
            NSDictionary *jsonData = [jsonDic objectForKey:@"data"];
            if ([jsonData objectForKey:@"articles"] != nil) {
                NSArray *jsonArticles = [jsonData objectForKey:@"articles"];
                for(int i=0;i<[jsonArticles count];i++)
                {
                    ArticleModel *articleModel = [[ArticleModel alloc]init];
                    NSDictionary *jsonArticle = [jsonArticles objectAtIndex:i];
                    if(jsonArticle!=nil) {
                        if ([jsonArticle objectForKey:@"id"]) {
                            articleModel.article_id = [jsonArticle objectForKey:@"id"];
                        }
                        if ([jsonArticle objectForKey:@"date"]) {
                            articleModel.date = [jsonArticle objectForKey:@"date"];
                        }
                        if ([jsonArticle objectForKey:@"title"]) {
                            articleModel.title = [jsonArticle objectForKey:@"title"];
                        }
                        if ([jsonArticle objectForKey:@"short_description"]) {
                            articleModel.short_description = [jsonArticle objectForKey:@"short_description"];
                        }
                        if ([jsonArticle objectForKey:@"image"]) {
                            articleModel.image = [jsonArticle objectForKey:@"image"];
                        }
                        [arrayObject addObject:articleModel];
                    }
                }
            }
        }
    }
    return arrayObject;
}

-(ArticleModel *)getDetailArticleModel:(NSString *)acticle_id
{
    NSString *content = [self getStringFromURL:[NSString stringWithFormat:@"%@%@.json",URL_GetArticaleDetail,acticle_id]];
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
    NSDictionary *jsonStatus = [jsonDic objectForKey:@"status"];
    NSString *code = [jsonStatus objectForKey:@"code"];
    if([code isEqualToString:@"200"])
    {
        if([jsonDic objectForKey:@"data"] != nil)
        {
            NSDictionary *jsonData = [jsonDic objectForKey:@"data"];
            ArticleModel *articleModel = [[ArticleModel alloc]init];
            if ([jsonData objectForKey:@"content"]) {
                articleModel.content = [jsonData objectForKey:@"content"];
            }
            if ([jsonData objectForKey:@"id"]) {
                articleModel.article_id = [jsonData objectForKey:@"id"];
            }
            if ([jsonData objectForKey:@"coordinates"]) {
                NSDictionary *jsonLatLon = [jsonData objectForKey:@"coordinates"];
                if ([jsonLatLon objectForKey:@"lat"]) {
                    articleModel.lat = [jsonLatLon objectForKey:@"lat"];
                }
                if ([jsonLatLon objectForKey:@"long"]) {
                    articleModel.lon = [jsonLatLon objectForKey:@"long"];
                }
            }
            if ([jsonData objectForKey:@"image"]) {
                articleModel.image = [jsonData objectForKey:@"image"];
            }
            if ([jsonData objectForKey:@"title"]) {
                articleModel.title = [jsonData objectForKey:@"title"];
            }
            if ([jsonData objectForKey:@"type"]) {
                articleModel.type = [jsonData objectForKey:@"type"];
            }
            return articleModel;
        }
    }
    return nil;
}

@end
