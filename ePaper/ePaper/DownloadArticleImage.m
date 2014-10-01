//
//  DownloadArticleImage.m
//  ePaper
//
//  Created by Sanjay Dandekar on 30/09/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import "DownloadArticleImage.h"
#import "AppDelegate.h"

@implementation DownloadArticleImage

@synthesize imageUrl = _imageUrl;
@synthesize ctrl = _ctrl;

- (void) main
{
    // Get the file name of the jpeg file
    NSString* fileName = [self.imageUrl lastPathComponent];
    // Form the path to file
    NSString* filePath = [NSString stringWithFormat:@"%@/%@/%@/%@", [self applicationDocumentsDirectory], ((AppDelegate *)[UIApplication sharedApplication].delegate).dateString, ((AppDelegate *)[UIApplication sharedApplication].delegate).editionString, fileName];
    // Check if the file exists
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        // Download the file
        NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageUrl]];
        [self writeData:imageData toFile:filePath];
    }
    [self.ctrl imageDownloaded];
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

- (BOOL) writeData: (NSData*) data toFile: (NSString*) filePath
{
    NSError* error;
    BOOL retval = [data writeToFile:filePath options:0 error:&error];
    return retval;
}

@end
