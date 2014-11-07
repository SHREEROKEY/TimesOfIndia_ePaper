//
//  ArticleViewerController.h
//  ePaper
//
//  Created by Sanjay Dandekar on 19/09/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"
#import "Edition.h"

@interface ArticleViewerController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSString* imageUrl;

@property (strong, nonatomic) Article* article;

@property (strong, nonatomic) Edition* edition;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)playArticlePodcast:(id)sender;

- (void) imageDownloaded;

@end
