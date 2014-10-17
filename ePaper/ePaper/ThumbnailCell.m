//
//  ThumbnailCell.m
//  ePaper
//
//  Created by Sanjay Dandekar on 19/09/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import "ThumbnailCell.h"

@implementation ThumbnailCell

@synthesize thumbnail = _thumbnail;

- (void) loadThumbnail: (NSString *) url
{
    self.thumbnail.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
}

- (void) prepareForReuse
{
    self.thumbnail.image = nil;
    self.pageName.text = @"";
    [self.activityIndicator stopAnimating];
}

@end
