//
//  ArticleImageViewerController.m
//  ePaper
//
//  Created by Sanjay Dandekar on 19/09/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import "ArticleImageViewerController.h"
#import "DownloadArticleImage.h"
#import "AppDelegate.h"
#import "Utility.h"

@interface ArticleImageViewerController ()
{
    NSString* imagePath;
}
@end

@implementation ArticleImageViewerController

@synthesize webView = _webView;
@synthesize imageUrl = _imageUrl;
@synthesize article = _article;
@synthesize edition = _edition;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Get the file name of the jpeg file
    NSString* fileName = [self.imageUrl lastPathComponent];
    // Form the path to file
    NSString* editionStr = [NSString stringWithFormat:@"%d", (int)((AppDelegate *)[UIApplication sharedApplication].delegate).editionString.editionId];
    imagePath = [NSString stringWithFormat:@"%@/%@/%@/%@", [Utility applicationDocumentsDirectory], ((AppDelegate *)[UIApplication sharedApplication].delegate).dateString, editionStr, fileName];
    // Does the file exist
    if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath])
    {
        // Do any additional setup after loading the view.
        NSURL* url = [NSURL URLWithString:imagePath];
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
    else
    {
        // Download the file
        DownloadArticleImage* op = [[DownloadArticleImage alloc] init];
        op.ctrl = self;
        op.imageUrl = self.imageUrl;
        // Create operation queue
        NSOperationQueue* queue = [[NSOperationQueue alloc] init];
        // queue the operation
        [queue addOperation:op];
        // Show activity indicator
        [self.activityIndicator startAnimating];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) imageDownloaded
{
    // Get the file name of the jpeg file
    NSString* fileName = [self.imageUrl lastPathComponent];
    // Form the path to file
    NSString* editionStr = [NSString stringWithFormat:@"%d", (int)((AppDelegate *)[UIApplication sharedApplication].delegate).editionString.editionId];
    imagePath = [NSString stringWithFormat:@"%@/%@/%@/%@", [Utility applicationDocumentsDirectory], ((AppDelegate *)[UIApplication sharedApplication].delegate).dateString, editionStr, fileName];
    // Do any additional setup after loading the view.
    NSURL* url = [NSURL URLWithString:imagePath];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    dispatch_async(dispatch_get_main_queue(), ^{
        // Hide activity indicato
        [self.activityIndicator stopAnimating];
    });
}

@end
