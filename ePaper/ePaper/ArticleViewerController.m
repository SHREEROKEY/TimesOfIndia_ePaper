//
//  ArticleViewerController.m
//  ePaper
//
//  Created by Sanjay Dandekar on 19/09/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import "ArticleViewerController.h"
#import "AppDelegate.h"
#import "DownloadArticleHTML.h"
#import "Utility.h"
#import <AVFoundation/AVFoundation.h>

@interface ArticleViewerController ()
{
    NSString* htmlPath;
    AVPlayer *anAudioStreamer;
}
@end

@implementation ArticleViewerController

@synthesize webView = _webView;
@synthesize imageUrl = _imageUrl;
@synthesize article = _article;
@synthesize edition = _edition;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Form the path to file
    NSString* editionStr = [NSString stringWithFormat:@"%d", (int)((AppDelegate *)[UIApplication sharedApplication].delegate).editionString.editionId];
    htmlPath = [NSString stringWithFormat:@"%@/%@/%@/%@.html", [Utility applicationDocumentsDirectory], ((AppDelegate *)[UIApplication sharedApplication].delegate).dateString, editionStr, self.article.name];
    // Does the file exist
    if ([[NSFileManager defaultManager] fileExistsAtPath:htmlPath])
    {
        // Do any additional setup after loading the view.
        NSURL* url = [NSURL URLWithString:htmlPath];
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
    else
    {
        // Create operation queue
        NSOperationQueue* queue = [[NSOperationQueue alloc] init];
        //
        DownloadArticleHTML* op2 = [[DownloadArticleHTML alloc] init];
        op2.article = self.article;
        op2.edition = [NSString stringWithFormat:@"%d", (int)self.edition.editionId];
        op2.ctrl = self;
        [queue addOperation:op2];
        //
        // Show activity indicator
        [self.activityIndicator startAnimating];
    }
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (anAudioStreamer && anAudioStreamer )
    {
        [anAudioStreamer pause];
        anAudioStreamer = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) imageDownloaded
{
    // Form the path to file
    NSString* editionStr = [NSString stringWithFormat:@"%d", (int)((AppDelegate *)[UIApplication sharedApplication].delegate).editionString.editionId];
    htmlPath = [NSString stringWithFormat:@"%@/%@/%@/%@.html", [Utility applicationDocumentsDirectory], ((AppDelegate *)[UIApplication sharedApplication].delegate).dateString, editionStr, self.article.name];
    // Do any additional setup after loading the view.
    NSURL* url = [NSURL URLWithString:htmlPath];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    dispatch_async(dispatch_get_main_queue(), ^{
        // Hide activity indicato
        [self.activityIndicator stopAnimating];
    });
}

- (IBAction)playArticlePodcast:(id)sender
{
    // Get the item
    AVPlayerItem *aPlayerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:self.article.mp3Url]];
    anAudioStreamer = [[AVPlayer alloc] initWithPlayerItem:aPlayerItem];
    [anAudioStreamer play];
}

@end
