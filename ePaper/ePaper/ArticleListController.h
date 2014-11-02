//
//  ArticleListController.h
//  ePaper
//
//  Created by Sanjay Dandekar on 19/09/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Edition.h"

@interface ArticleListController : UITableViewController

@property (strong, nonatomic) NSArray* articles;

@property (strong, nonatomic) Edition* edition;

- (IBAction)showArticleImage:(id)sender;

- (IBAction)playArticlePodcast:(id)sender;

@end
