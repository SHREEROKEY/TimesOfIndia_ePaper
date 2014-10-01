//
//  ArticleViewerController.m
//  ePaper
//
//  Created by Sanjay Dandekar on 19/09/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import "ArticleViewerController.h"
#import "DownloadArticleImage.h"
#import "AppDelegate.h"

@interface ArticleViewerController ()

@end

@implementation ArticleViewerController

@synthesize webView = _webView;
@synthesize imageUrl = _imageUrl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Get the file name of the jpeg file
    NSString* fileName = [self.imageUrl lastPathComponent];
    // Form the path to file
    NSString* filePath = [NSString stringWithFormat:@"%@/%@/%@/%@", [self applicationDocumentsDirectory], ((AppDelegate *)[UIApplication sharedApplication].delegate).dateString, ((AppDelegate *)[UIApplication sharedApplication].delegate).editionString, fileName];
    // Does the file exist
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        // Do any additional setup after loading the view.
        NSURL* url = [NSURL URLWithString:filePath];
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
    NSString* filePath = [NSString stringWithFormat:@"%@/%@/%@/%@", [self applicationDocumentsDirectory], ((AppDelegate *)[UIApplication sharedApplication].delegate).dateString, ((AppDelegate *)[UIApplication sharedApplication].delegate).editionString, fileName];
    // Do any additional setup after loading the view.
    NSURL* url = [NSURL URLWithString:filePath];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

/**
 Returns the URL to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

@end
