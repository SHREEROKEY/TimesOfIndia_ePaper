//
//  Article.h
//  ePaper
//
//  Created by Sanjay Dandekar on 19/09/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Article : NSObject

@property (copy, nonatomic) NSString* name;
@property (copy, nonatomic) NSString* title;
@property (copy, nonatomic) NSString* body;
@property (copy, nonatomic) NSString* imageUrl;
@property (copy, nonatomic) NSString* articleImageUrl;
@property (strong, nonatomic) UIImage* articleImage;
@property (copy, nonatomic) NSString* mp3Url;

@end
