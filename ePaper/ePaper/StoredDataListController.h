//
//  StoredDataListController.h
//  ePaper
//
//  Created by Sanjay Dandekar on 01/10/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoredDataListController : UITableViewController

@property (nonatomic, strong) NSMutableArray* dayDetails;

- (IBAction)closePopover:(id)sender;

- (void) dataAvailable;

@end
