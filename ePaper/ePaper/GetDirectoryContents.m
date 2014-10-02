//
//  GetDirectoryContents.m
//  ePaper
//
//  Created by Sanjay Dandekar on 01/10/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import "GetDirectoryContents.h"
#import "DayDetail.h"

@implementation GetDirectoryContents

@synthesize ctrl = _ctrl;

- (void) main
{
    //
    NSError* error = nil;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyymmdd"];
    NSDateFormatter *dateDisplayFormat = [[NSDateFormatter alloc] init];
    [dateDisplayFormat setDateFormat:@"dd MMM yyyy"];
    NSMutableArray* details = [[NSMutableArray alloc] init];
    // Get the documents directory
    NSString* documentsDir = [self applicationDocumentsDirectory];
    // Now get list of contents in the documents directory
    NSArray* contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDir error:&error];
    // do we have the contents
    if (contents != nil)
    {
        for (NSString* folderName in contents)
        {
            // create a path with folder name and documents dir
            NSString* subFolder = [NSString stringWithFormat:@"%@/%@", documentsDir, folderName];
            // Get folder size
            NSInteger size = [self folderSize:subFolder];
            // Create an array of DayDetail
            DayDetail* detail = [[DayDetail alloc] init];
            NSDate *date = [dateFormat dateFromString:folderName];
            detail.date = [dateDisplayFormat stringFromDate:date];
            detail.size = [NSString stringWithFormat:@"%ld Mb", (long)size];
            detail.folderPath = subFolder;
            // add it to the array
            [details addObject:detail];
        }
    }
    // now set it on controller
    self.ctrl.dayDetails = details;
    // Tell controller to load it self
    [self.ctrl dataAvailable];
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

- (NSInteger) folderSize:(NSString *)folderPath
{
    NSArray *filesArray = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:folderPath error:nil];
    NSEnumerator *filesEnumerator = [filesArray objectEnumerator];
    NSString *fileName;
    unsigned long long fileSize = 0;
    NSError* error = nil;
    
    while (fileName = [filesEnumerator nextObject])
    {
        NSDictionary *fileDictionary = [[NSFileManager defaultManager] attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:fileName] error:&error];
        fileSize += [fileDictionary fileSize];
    }
    
    NSInteger tempSize = (int)(fileSize / (1024 * 1024));
    
    return tempSize;
}

@end
