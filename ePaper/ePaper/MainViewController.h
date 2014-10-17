//
//  MainViewController.h
//  ePaper
//
//  Created by Sanjay Dandekar on 19/09/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Edition.h"

@interface MainViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView* collectionView;

@property (weak, nonatomic) IBOutlet UIView* blockingScreen;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView* activityIndicator;

@property (strong, nonatomic) NSArray* pages;

@property (strong, nonatomic) Edition* edition;

@property (copy, nonatomic) NSString* cityName;

- (void) dataUpdated;

- (void) reloadCellAtIndex: (int) cellPosition;

@end
