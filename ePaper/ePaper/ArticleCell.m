//
//  ArticleCell.m
//  ePaper
//
//  Created by Sanjay Dandekar on 19/09/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import "ArticleCell.h"

@implementation ArticleCell

@synthesize articleTitle = _articleTitle;
@synthesize articleDetail = _articleDetail;

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        CGFloat fontSize = self.articleDetail.font.pointSize * 1.4;
        self.articleDetail.font = [UIFont fontWithName:self.articleDetail.font.fontName size:fontSize];
        fontSize = self.articleTitle.font.pointSize * 1.4;
        self.articleTitle.font = [UIFont fontWithName:self.articleTitle.font.fontName size:fontSize];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
