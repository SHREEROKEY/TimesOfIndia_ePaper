//
//  MainViewController.h
//  ePaper
//
//  Created by Sanjay Dandekar on 19/09/14.
//  Copyright (c) 2014 An Indian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView* collectionView;

@property (weak, nonatomic) IBOutlet UIView* blockingScreen;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView* activityIndicator;

@property (strong, nonatomic) NSArray* pages;

@property (copy, nonatomic) NSString* edition;

@property (copy, nonatomic) NSString* cityName;

- (void) dataUpdated;

@end
