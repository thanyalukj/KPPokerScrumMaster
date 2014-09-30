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
#import "BaseSession.h"
#import "ScoreInteractor.h"
#import "BaseScore.h"

@interface DetailViewController () <UICollectionViewDataSource, UICollectionViewDelegate, ScoreInteracting>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) ScoreInteractor *scoreInteractor;
@property (nonatomic) NSArray *scores;
@end

@implementation DetailViewController {
    NSTimer *_refreshTimer;
}

- (void)configureCollectionView {
    UINib *cellNib = [UINib nibWithNibName:@"UserCardCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"userCardCell"];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

#pragma mark - Managing the detail item
- (void)setStory:(StoryModel *)story sessions:(NSArray *)sessions {
    [self setSessions:sessions];
    [self setDetailStory:story];
}

- (void)setSessions:(NSArray *)sessions {
    if (_sessions != sessions) {
        _sessions = sessions;
        [self reloadData];
    }
}

- (void)setDetailStory:(StoryModel *)detailStory {
    if (_detailStory != detailStory) {
        _detailStory = detailStory;
        [self.scoreInteractor start];
    }
}

- (ScoreInteractor *)scoreInteractor {
    if (!_scoreInteractor) {
        _scoreInteractor = [[ScoreInteractor alloc] initWithStoryId:_detailStory.title];
        _scoreInteractor.delegate = self;
    }
    return _scoreInteractor;
}

- (void)reloadData {
    if (self.detailStory && self.sessions) {
        self.title = _detailStory.title;
        [self.collectionView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureCollectionView];
    [self reloadData];
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
    if (self.scores) {
        NSString *score = [self scoreForPersonId:baseSession.personId];
        [cell setScore:score];
    }
    return cell;
}

- (NSString *)scoreForPersonId:(NSString *)personId {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(storyId == %@) AND (personId == %@)", self.detailStory.title, personId];
    NSArray *searchResults = [NSArray arrayWithArray:[self.scores filteredArrayUsingPredicate:predicate]];
    if ([searchResults count] == 1){
        BaseScore *baseScore = [searchResults firstObject];
        return baseScore.score;
    } else {
        return nil;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UserCard *card = _detailStory.userCards[(NSUInteger) indexPath.row];
    _detailStory.score = [[card.card.content stringByReplacingOccurrencesOfString:@"shirt_" withString:@""] uppercaseString];
}

#pragma mark - Score

- (void)setScores:(NSArray *)scores {
    _scores = scores;
    [self reloadData];
    [self createRefreshTimer];
}

#pragma mark - refresh
- (void)createRefreshTimer {
    [_refreshTimer invalidate];
    _refreshTimer = [NSTimer scheduledTimerWithTimeInterval:5.0f
                                                     target:self
                                                   selector:@selector(refreshScores)
                                                   userInfo:nil
                                                    repeats:NO];
}
- (void)refreshScores {
    [self.scoreInteractor start];
}

@end
