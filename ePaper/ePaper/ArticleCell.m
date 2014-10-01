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

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
