//
//  FetchDayIndexData.h
//  ePaper
//
//  Created by Sanjay Dandekar on 19/09/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"
#import "Edition.h"

@interface FetchDayIndexData : NSOperation

@property (strong, nonatomic) Edition* edition;
@property (copy, nonatomic) NSString* cityName;
@property (copy, nonatomic) NSString* date;
@property (strong, nonatomic) MainViewController* ctrl;

@end
