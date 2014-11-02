//
//  DownloadArticleHTML.h
//  ePaper
//
//  Created by Sanjay Dandekar on 22/10/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Article.h"
#import "ArticleViewerController.h"

@interface DownloadArticleHTML : NSOperation

@property (strong, nonatomic) Article* article;

@property (copy, nonatomic) NSString* edition;

@property (nonatomic, strong) ArticleViewerController* ctrl;

@end
