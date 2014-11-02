//
//  Utility.m
//  ePaper
//
//  Created by Sanjay Dandekar on 23/10/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (NSString *)applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

+ (BOOL) writeData: (NSData*) data toFile: (NSString*) filePath
{
    NSError* error;
    BOOL retval = [data writeToFile:filePath options:0 error:&error];
    return retval;
}


@end
