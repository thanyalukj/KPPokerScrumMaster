//
//  DetailViewController.m
//  KPPokerScrumMaster
//
//  Created by Thanyaluk on 29/09/2014.
//  Copyright (c) 2014 Kotikan. All rights reserved.
//

#import "DetailViewController.h"
#import "StoryModel.h"
#import "SessionsInteractor.h"
#import "UserCardCell.h"
#import "SessionsTable.h"
#import "UserCard.h"
#import "Card.h"
#import "SessionModel.h"
#import "BaseSession.h"

@interface DetailViewController () <UICollectionViewDataSource, UICollectionViewDelegate, SessionsInteracting>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation DetailViewController

- (void)configureCollectionView {
    UINib *cellNib = [UINib nibWithNibName:@"UserCardCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"userCardCell"];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

#pragma mark - Managing the detail item

- (void)setSessions:(NSArray *)sessions {
    if (_sessions != sessions) {
        _sessions = sessions;
        [self configureView];
    }
}

- (void)configureView {
    if (self.detailStory) {
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
    return [self.sessions count];
}

static NSString *cellIdentifier = @"userCardCell";

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BaseSession *baseSession = (BaseSession *)self.sessions[(NSUInteger)indexPath.row];
    UserCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell setSession:baseSession];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UserCard *card = _detailStory.userCards[(NSUInteger) indexPath.row];
    _detailStory.score = [[card.card.content stringByReplacingOccurrencesOfString:@"shirt_" withString:@""] uppercaseString];
}

@end
