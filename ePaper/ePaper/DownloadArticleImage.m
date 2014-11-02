//
//  DownloadArticleImage.m
//  ePaper
//
//  Created by Sanjay Dandekar on 30/09/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import "DownloadArticleImage.h"
#import "AppDelegate.h"
#import "Utility.h"

@implementation DownloadArticleImage

@synthesize imageUrl = _imageUrl;
@synthesize ctrl = _ctrl;

- (void) main
{
    // Get the file name of the jpeg file
    NSString* fileName = [self.imageUrl lastPathComponent];
    NSString* editionStr = [NSString stringWithFormat:@"%d", (int)((AppDelegate *)[UIApplication sharedApplication].delegate).editionString.editionId];
    // Form the path to file
    NSString* filePath = [NSString stringWithFormat:@"%@/%@/%@/%@", [Utility applicationDocumentsDirectory], ((AppDelegate *)[UIApplication sharedApplication].delegate).dateString, editionStr, fileName];
    // Check if the file exists
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        // Download the file
        NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageUrl]];
        [Utility writeData:imageData toFile:filePath];
    }
    [self.ctrl imageDownloaded];
}

@end
