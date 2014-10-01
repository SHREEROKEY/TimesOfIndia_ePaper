//
//  WelcomeController.m
//  ePaper
//
//  Created by Sanjay Dandekar on 20/09/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import "WelcomeController.h"
#import "MainViewController.h"

@interface WelcomeController ()
{
    NSString* edition;
    NSString* cityName;
}
@end

@implementation WelcomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Welcome";
    self.navigationItem.prompt = @"Please select the city";
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

- (IBAction)citySelected:(id)sender
{
    // get the view that was tapped
    UIButton* lbl = (UIButton* )sender;
    // the edition is the tag
    NSLog(@"lbl.tag -> %d", (int)lbl.tag);
    //
    edition = [NSString stringWithFormat:@"%d", (int)lbl.tag];
    cityName = [lbl.titleLabel.text uppercaseString];
    //
    [self performSegueWithIdentifier:@"ShowPaper" sender:self];
}
@end
