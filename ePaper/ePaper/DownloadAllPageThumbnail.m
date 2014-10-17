//
//  DownloadAllPageThumbnail.m
//  ePaper
//
//  Created by Sanjay Dandekar on 17/10/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import "DownloadAllPageThumbnail.h"
#import "Page.h"

@implementation DownloadAllPageThumbnail

@synthesize pages = _pages;
@synthesize ctrl = _ctrl;

- (void) main
{
    // Maintain a counter
    int counter = 0;
    for (Page* page in self.pages)
    {
        if (page.thumbnailImage == nil)
        {
            // Create URL to download the image from
            NSURL* url = [NSURL URLWithString:page.thumbnailUrl];
            // Get data of the thumbnail
            NSData* imageData = [NSData dataWithContentsOfURL:url];
            // Save this data on disk
            [self writeData:imageData toFile:page.localPath];
            // Convert this to image
            UIImage* image = [UIImage imageWithData:imageData];
            // Assign this to the page thumbnail
            page.thumbnailImage = image;
            // Inform the controller to reload the cell
            [self.ctrl reloadCellAtIndex: counter];
        }
        // Increment the counter
        counter++;
    }
}

- (BOOL) writeData: (NSData*) data toFile: (NSString*) filePath
{
    NSError* error;
    BOOL retval = [data writeToFile:filePath options:0 error:&error];
    return retval;
}

@end
