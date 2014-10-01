//
//  ArticleViewerController.h
//  ePaper
//
//  Created by Sanjay Dandekar on 19/09/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleViewerController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSString* imageUrl;

- (void) imageDownloaded;

@end
