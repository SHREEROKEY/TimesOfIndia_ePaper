//
//  GetDirectoryContents.h
//  ePaper
//
//  Created by Sanjay Dandekar on 01/10/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoredDataListController.h"

@interface GetDirectoryContents : NSOperation

@property (nonatomic, strong) StoredDataListController* ctrl;

@end
