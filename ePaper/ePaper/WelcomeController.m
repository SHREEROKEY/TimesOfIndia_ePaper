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
    Edition* edition;
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
    ed.editionName = @"ToI - Ahmedabad";
    ed.editionPath = @"TheTimesOfIndia";
    ed.color = [UIColor redColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31819;
    ed.editionName = @"Mirror - Ahmedabad";
    ed.editionPath = @"Mirror";
    ed.color = [UIColor greenColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31806;
    ed.editionName = @"ToI - Bangalore";
    ed.editionPath = @"TheTimesOfIndia";
    ed.color = [UIColor blueColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31815;
    ed.editionName = @"ET - Bangalore";
    ed.editionPath = @"TheEconomicTimes";
    ed.color = [UIColor cyanColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31820;
    ed.editionName = @"Mirror - Bangalore";
    ed.editionPath = @"Mirror";
    ed.color = [UIColor yellowColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31807;
    ed.editionName = @"ToI - Chennai";
    ed.editionPath = @"TheTimesOfIndia";
    ed.color = [UIColor magentaColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31808;
    ed.editionName = @"ToI - Delhi";
    ed.editionPath = @"TheTimesOfIndia";
    ed.color = [UIColor orangeColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31816;
    ed.editionName = @"ET - Delhi";
    ed.editionPath = @"TheEconomicTimes";
    ed.color = [UIColor purpleColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31809;
    ed.editionName = @"ToI - Hyderabad";
    ed.editionPath = @"TheTimesOfIndia";
    ed.color = [UIColor brownColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31810;
    ed.editionName = @"ToI - Jaipur";
    ed.editionPath = @"TheTimesOfIndia";
    ed.color = [UIColor redColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31811;
    ed.editionName = @"ToI - Kochi";
    ed.editionPath = @"TheTimesOfIndia";
    ed.color = [UIColor greenColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31812;
    ed.editionName = @"ToI - Kolkata";
    ed.editionPath = @"TheTimesOfIndia";
    ed.color = [UIColor cyanColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31817;
    ed.editionName = @"ET - Kolkata";
    ed.editionPath = @"TheEconomicTimes";
    ed.color = [UIColor yellowColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31813;
    ed.editionName = @"ToI - Lucknow";
    ed.editionPath = @"TheTimesOfIndia";
    ed.color = [UIColor magentaColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31804;
    ed.editionName = @"ToI - Mumbai";
    ed.editionPath = @"TheTimesOfIndia";
    ed.color = [UIColor orangeColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31818;
    ed.editionName = @"ET - Mumbai";
    ed.editionPath = @"TheEconomicTimes";
    ed.color = [UIColor purpleColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31821;
    ed.editionName = @"Mirror - Mumbai";
    ed.editionPath = @"Mirror";
    ed.color = [UIColor brownColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31840;
    ed.editionName = @"ToI - NaviMumbai";
    ed.editionPath = @"TheTimesOfIndia";
    ed.color = [UIColor redColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31814;
    ed.editionName = @"ToI - Pune";
    ed.editionPath = @"TheTimesOfIndia";
    ed.color = [UIColor greenColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31822;
    ed.editionName = @"Mirror - Pune";
    ed.editionPath = @"Mirror";
    ed.color = [UIColor cyanColor];
    [editions addObject: ed];
    //
    ed = [[Edition alloc] init];
    ed.editionId = 31839;
    ed.editionName = @"ToI - Thane";
    ed.editionPath = @"TheTimesOfIndia";
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
    edition = [editions objectAtIndex:indexPath.item];
    NSRange rangeOfHyphen = [edition.editionName rangeOfString:@"- "];
    cityName = [[edition.editionName uppercaseString] substringFromIndex:rangeOfHyphen.location + 2];
    //
    [self performSegueWithIdentifier:@"ShowPaper" sender:self];
    //
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
