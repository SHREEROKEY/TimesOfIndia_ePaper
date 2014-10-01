//
//  StoredDataListController.m
//  ePaper
//
//  Created by Sanjay Dandekar on 01/10/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import "StoredDataListController.h"
#import "DayDetailCell.h"
#import "DayDetail.h"
#import "GetDirectoryContents.h"
#import "DeleteFolder.h"

@interface StoredDataListController ()
{
    NSOperationQueue* queue;
}
@end

@implementation StoredDataListController

@synthesize dayDetails = _dayDetails;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    [self.navigationController setToolbarHidden:NO animated:YES];
    //
    GetDirectoryContents* op = [[GetDirectoryContents alloc] init];
    op.ctrl = self;
    queue = [[NSOperationQueue alloc] init];
    [queue addOperation:op];
    //
    self.title = @"Stored Data";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (self.dayDetails != nil)
    {
        return self.dayDetails.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DayDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StorageInfoCell" forIndexPath:indexPath];
    
    // Configure the cell...
    DayDetail* detail = [self.dayDetails objectAtIndex:indexPath.item];
    cell.dateLabel.text = detail.date;
    cell.sizeLabel.text = detail.size;
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        DayDetail* detail = [self.dayDetails objectAtIndex:indexPath.item];
        NSString* path = detail.folderPath;
        //
        DeleteFolder* df = [[DeleteFolder alloc] init];
        df.path = path;
        [queue addOperation:df];
        //
        [self.dayDetails removeObjectAtIndex:indexPath.item];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (IBAction)closePopover:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) dataAvailable
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

@end
