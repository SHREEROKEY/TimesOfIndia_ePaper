//
//  Page.h
//  ePaper
//
//  Created by Sanjay Dandekar on 19/09/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Page : NSObject

@property (copy, nonatomic) NSString* name;
@property (copy, nonatomic) NSString* title;
@property (copy, nonatomic) NSString* thumbnailUrl;
@property (strong, nonatomic) NSArray* articles;
@property (strong, nonatomic) UIImage* thumbnailImage;
@property (strong, nonatomic) NSString* localPath;

@end
