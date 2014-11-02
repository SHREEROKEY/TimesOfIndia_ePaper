//
//  Utility.h
//  ePaper
//
//  Created by Sanjay Dandekar on 23/10/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

+ (NSString *)applicationDocumentsDirectory;

+ (BOOL) writeData: (NSData*) data toFile: (NSString*) filePath;

@end
