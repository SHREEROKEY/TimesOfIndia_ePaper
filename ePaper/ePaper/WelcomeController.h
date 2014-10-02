//
//  WelcomeController.h
//  ePaper
//
//  Created by Sanjay Dandekar on 20/09/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomeController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
