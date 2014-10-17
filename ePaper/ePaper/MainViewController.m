//
//  MainViewController.m
//  ePaper
//
//  Created by Sanjay Dandekar on 19/09/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import "MainViewController.h"
#import "ThumbnailCell.h"
#import "FetchDayIndexData.h"
#import "Page.h"
#import "Article.h"
#import "ArticleListController.h"
#import "AppDelegate.h"
#import "DownloadAllPageThumbnail.h"

@interface MainViewController ()
{
    NSString* date;
    NSString* month;
    NSString* monthName;
    NSString* year;
    NSString* baseUrlThumb;
    NSString* baseUrl;
    NSOperationQueue* queue;
    NSDate* now;
    int pageNumber;
    UIBarButtonItem *previousItem;
    UIBarButtonItem *nextItem;
    NSMutableArray* pageArticleArray;
}

@end

@implementation MainViewController

@synthesize collectionView = _collectionView;
@synthesize activityIndicator = _activityIndicator;
@synthesize pages = _pages;

- (void) dataUpdated
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.pages != nil)
        {
            [self.collectionView reloadData];
            [self.activityIndicator stopAnimating];
            self.blockingScreen.hidden = YES;
            // Now create DownloadAllPageThumbnail and schedule it for execution
            DownloadAllPageThumbnail* op = [[DownloadAllPageThumbnail alloc] init];
            op.pages = self.pages;
            op.ctrl = self;
            // schedule iperation
            [queue addOperation:op];
        }
        else
        {
            [self.collectionView reloadData];
            [self.activityIndicator stopAnimating];
            self.blockingScreen.hidden = YES;
            UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to get ePaper. You can only access it in India." delegate:self cancelButtonTitle:@"Close" otherButtonTitles: nil];
            [av show];
        }
    });
}

- (void) reloadCellAtIndex: (int) cellPosition
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSIndexPath* path = [NSIndexPath indexPathForItem:cellPosition inSection:0];
        [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects: path, nil]];
    });
}

- (void)loadData
{
    [self.activityIndicator startAnimating];
    self.blockingScreen.hidden = NO;
    //
    NSDateFormatter* datef = [[NSDateFormatter alloc] init];
    [datef setDateFormat:@"dd"];
    date = [datef stringFromDate:now];
    [datef setDateFormat:@"MM"];
    month = [datef stringFromDate:now];
    [datef setDateFormat:@"yyyy"];
    year = [datef stringFromDate:now];
    //
    [datef setDateFormat:@"MMM"];
    monthName = [datef stringFromDate:now];
    //
    baseUrlThumb = [NSString stringWithFormat:@"http://epaperbeta.timesofindia.com/NasData//PUBLICATIONS/THETIMESOFINDIA/%@/%@/%@/%@/PageThumb/%@_%@_%@_", self.cityName, year, month, date, date, month, year];
    baseUrl = [NSString stringWithFormat:@"http://epaperbeta.timesofindia.com/NasData//PUBLICATIONS/THETIMESOFINDIA/%@/%@/%@/%@/Page/%@_%@_%@_", self.cityName, year, month, date, date, month, year];
    //
    self.title =  [NSString stringWithFormat:@"%@ (%@-%@-%@)", self.edition.editionName, date, monthName, year];
    //
    FetchDayIndexData* op = [[FetchDayIndexData alloc] init];
    op.ctrl = self;
    op.edition = self.edition;
    op.cityName = self.cityName;
    op.date = [NSString stringWithFormat:@"%@%@%@", year, month, date];
    // assign this value to app delegate property so that everyone can access it
    ((AppDelegate *)[UIApplication sharedApplication].delegate).dateString = op.date;
    ((AppDelegate *)[UIApplication sharedApplication].delegate).editionString = op.edition;
    //
    queue = [[NSOperationQueue alloc] init];
    [queue addOperation:op];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //
    now = [NSDate date];
    //
    [self loadData];
    //
    self.automaticallyAdjustsScrollViewInsets = NO;
    //
    previousItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(previousDay)];
    
    nextItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forward"] style:UIBarButtonItemStylePlain target:self action:@selector(nextDay)];
    nextItem.enabled = NO;
    
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:nextItem, previousItem, nil];
}

- (void) previousDay
{
    // Get the previous day - this will always be successful
    now = [now dateByAddingTimeInterval: (-1 * 24 * 60 * 60)];
    //
    [self loadData];
    //
    nextItem.enabled = YES;
}

- (void) nextDay
{
    // We have to check if now is today's date or not
    now = [now dateByAddingTimeInterval: (24 * 60 * 60)];
    // Load the data
    [self loadData];
    // If now is today's date then disable next
    NSDate* tempDate = [NSDate date];
    //
    NSDateFormatter* datef = [[NSDateFormatter alloc] init];
    [datef setDateFormat:@"dd"];
    NSString* date1 = [datef stringFromDate:tempDate];
    NSString* date2 = [datef stringFromDate:now];
    [datef setDateFormat:@"MM"];
    NSString* month1 = [datef stringFromDate:tempDate];
    NSString* month2 = [datef stringFromDate:now];
    [datef setDateFormat:@"yyyy"];
    NSString* year1 = [datef stringFromDate:tempDate];
    NSString* year2 = [datef stringFromDate:now];
    //
    if ([date1 isEqualToString: date2] && [year1 isEqualToString: year2] && [month1 isEqualToString: month2])
    {
        nextItem.enabled = NO;
    }
    else
    {
        nextItem.enabled = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ShowArticle"])
    {
        ArticleListController* ctrl = segue.destinationViewController;
        Page* page = [self.pages objectAtIndex:pageNumber];
        ctrl.articles = page.articles;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    pageNumber = (int)indexPath.item;
    [self performSegueWithIdentifier:@"ShowArticle" sender:self];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.pages.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ThumbnailCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ThumbnailCell" forIndexPath:indexPath];
    Page* page = [self.pages objectAtIndex:indexPath.item];
    if (page.thumbnailImage != nil)
    {
        cell.thumbnail.image = page.thumbnailImage;
        [cell.activityIndicator stopAnimating];
    }
    else
    {
        [cell.activityIndicator startAnimating];
    }
    cell.pageName.text = page.title;
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


@end
