//
//  ArticleListController.m
//  ePaper
//
//  Created by Sanjay Dandekar on 19/09/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import "ArticleListController.h"
#import "ArticleCell.h"
#import "Article.h"
#import "ArticleViewerController.h"
#import <AVFoundation/AVFoundation.h>

@interface ArticleListController ()
{
    ArticleViewerController* ctrl;
    Article* article;
    AVPlayer *anAudioStreamer;
}
@end

@implementation ArticleListController

@synthesize articles = _articles;
@synthesize edition = _edition;

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    return self.articles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArticleCell" forIndexPath:indexPath];
    
    Article* art = [self.articles objectAtIndex:indexPath.item];

    // Configure the cell...
    cell.articleTitle.text = art.title;
    cell.articleDetail.text = art.body;
    if ([cell.articleDetail.text isEqualToString:@"..."])
    {
        cell.articleImgButton.hidden = YES;
        cell.podcastButton.hidden = YES;
        cell.articleDetail.hidden = YES;
        cell.articleDetail.text = @"";
    }
    else
    {
        cell.articleImgButton.hidden = NO;
        cell.podcastButton.hidden = NO;
        cell.articleDetail.hidden = NO;
    }
    cell.articleImgButton.tag = indexPath.item;
    cell.podcastButton.tag = indexPath.item;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get the item
    article = [self.articles objectAtIndex:indexPath.item];
    NSString* artbody = article.body;
    if ([artbody isEqualToString:@"..."])
    {
        // Now invoke the segue to show image
        [self performSegueWithIdentifier:@"ShowSingleArticleImage" sender:self];
    }
    else
    {
        // Now invoke the segue to show image
        [self performSegueWithIdentifier:@"ShowSingleArticle" sender:self];
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Article* art = [self.articles objectAtIndex:indexPath.item];
    NSString* artbody = art.body;
    if ([artbody isEqualToString:@"..."])
    {
        return 75;
    }
    else
    {
        return 145;
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ShowSingleArticle"])
    {
        ctrl = segue.destinationViewController;
        ctrl.imageUrl = article.imageUrl;
        ctrl.title = article.title;
        ctrl.article = article;
        ctrl.edition = self.edition;
    }
    else if ([segue.identifier isEqualToString:@"ShowSingleArticleImage"])
    {
        ctrl = segue.destinationViewController;
        ctrl.imageUrl = article.imageUrl;
        ctrl.title = article.title;
        ctrl.article = article;
        ctrl.edition = self.edition;
    }
}

- (IBAction)showArticleImage:(id)sender
{
    // Get the tag of the button
    NSInteger tag = ((UIButton *)sender).tag;
    // Get the item
    article = [self.articles objectAtIndex:tag];
    // Now invoke the segue to show image
    [self performSegueWithIdentifier:@"ShowSingleArticleImage" sender:self];
}

- (IBAction)playArticlePodcast:(id)sender
{
    // Get the tag of the button
    NSInteger tag = ((UIButton *)sender).tag;
    // Get the item
    article = [self.articles objectAtIndex:tag];
    AVPlayerItem *aPlayerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:article.mp3Url]];
    anAudioStreamer = [[AVPlayer alloc] initWithPlayerItem:aPlayerItem];
    [anAudioStreamer play];
}

@end
