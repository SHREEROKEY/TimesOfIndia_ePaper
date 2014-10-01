//
//  DeleteFolder.m
//  ePaper
//
//  Created by Sanjay Dandekar on 01/10/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import "DeleteFolder.h"

@implementation DeleteFolder

@synthesize path = _path;

- (void) main
{
    NSError* error = nil;
    [[NSFileManager defaultManager] removeItemAtPath:self.path error:&error];
    NSLog(@"error -> %@", error);
}

@end
