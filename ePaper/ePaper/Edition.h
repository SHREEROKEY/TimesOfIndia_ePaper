//
//  Edition.h
//  ePaper
//
//  Created by Sanjay Dandekar on 01/10/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Edition : NSObject

@property (nonatomic, assign) NSInteger editionId;

@property (nonatomic, copy) NSString* editionName;

@property (nonatomic, strong) UIColor* color;

@property (nonatomic, copy) NSString* editionPath;

@end
