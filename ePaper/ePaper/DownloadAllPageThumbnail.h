//
//  DownloadAllPageThumbnail.h
//  ePaper
//
//  Created by Sanjay Dandekar on 17/10/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"

@interface DownloadAllPageThumbnail : NSOperation

@property (strong, nonatomic) NSArray* pages;

@property (strong, nonatomic) MainViewController* ctrl;

@end
