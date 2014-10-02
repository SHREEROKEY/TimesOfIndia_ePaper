//
//  WelcomeController.m
//  ePaper
//
//  Created by Sanjay Dandekar on 20/09/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import "WelcomeController.h"
#import "MainViewController.h"
#import "Edition.h"
#import "EditionCell.h"

@interface WelcomeController ()
{
    NSString* edition;
    NSString* cityName;
    NSMutableArray* editions;
}
@end

@implementation WelcomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Welcome";
    self.navigationItem.prompt = @"Please select the city";
    self.automaticallyAdjustsScrollViewInsets = NO;
    // create editions
    [self createEditions];
    //
    [self.tableView registerNib:[UINib nibWithNibName:@"EditionCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"EditionCell"];
}

- (void) createEditions
{
    editions = [[NSMutableArray alloc] init];
    //
    Edition* ed = [[Edition alloc] init];
    ed.editionId = 31805;
    ed.editionName = @"Ahmedabad";
    ed.color = [UIColor redColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31806;
    ed.editionName = @"Bangalore";
    ed.color = [UIColor greenColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31807;
    ed.editionName = @"Chennai";
    ed.color = [UIColor blueColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31808;
    ed.editionName = @"Delhi";
    ed.color = [UIColor cyanColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31809;
    ed.editionName = @"Hyderabad";
    ed.color = [UIColor yellowColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31810;
    ed.editionName = @"Jaipur";
    ed.color = [UIColor magentaColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31811;
    ed.editionName = @"Kochi";
    ed.color = [UIColor orangeColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31812;
    ed.editionName = @"Kolkata";
    ed.color = [UIColor purpleColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31813;
    ed.editionName = @"Lucknow";
    ed.color = [UIColor brownColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31804;
    ed.editionName = @"Mumbai";
    ed.color = [UIColor redColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31840;
    ed.editionName = @"Navi Mumbai";
    ed.color = [UIColor greenColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31806;
    ed.editionName = @"Bangalore";
    ed.color = [UIColor blueColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31814;
    ed.editionName = @"Pune";
    ed.color = [UIColor cyanColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31839;
    ed.editionName = @"Thane";
    ed.color = [UIColor yellowColor];
    [editions addObject: ed];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ShowPaper"])
    {
        MainViewController* ctrl = segue.destinationViewController;
        ctrl.edition = edition;
        ctrl.cityName = cityName;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return editions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditionCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"EditionCell" forIndexPath:indexPath];
    Edition* ed = [editions objectAtIndex:indexPath.item];
    cell.editionNameLabel.text = ed.editionName;
    cell.backgroundColor = [ed.color colorWithAlphaComponent:0.6];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Edition* ed = [editions objectAtIndex:indexPath.item];
    edition = [NSString stringWithFormat:@"%d", (int)ed.editionId];
    cityName = [ed.editionName uppercaseString];
    //
    [self performSegueWithIdentifier:@"ShowPaper" sender:self];
    //
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
