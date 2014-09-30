//
//  DetailViewController.m
//  KPPokerScrumMaster
//
//  Created by Thanyaluk on 29/09/2014.
//  Copyright (c) 2014 Kotikan. All rights reserved.
//

#import "DetailViewController.h"
#import "Story.h"
#import "UserCard.h"
#import "UserCardCell.h"
#import "Card.h"

@interface DetailViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation DetailViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configureCollectionView];
    }
    return self;
}

- (void)configureCollectionView {
    UINib *cellNib = [UINib nibWithNibName:@"UserCardCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"userCardCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

#pragma mark - Managing the detail item

- (void)setDetailStory:(id)newDetailStory {
    if (_detailStory != newDetailStory) {
        _detailStory = newDetailStory;

        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (_detailStory) {
        self.title = _detailStory.title;
        [self.collectionView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureCollectionView];
    [self configureView];
}

#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_detailStory.userCards count];
}

static NSString *cellIdentifier = @"userCardCell";
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UserCard *card = _detailStory.userCards[(NSUInteger)indexPath.row];
    UserCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell setUserCard:card];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UserCard *card = _detailStory.userCards[(NSUInteger)indexPath.row];
    _detailStory.score = [[card.card.content stringByReplacingOccurrencesOfString:@"shirt_" withString:@""] uppercaseString];
}

@end
