//
//  DetailViewController.m
//  KPPokerScrumMaster
//
//  Created by Thanyaluk on 29/09/2014.
//  Copyright (c) 2014 Kotikan. All rights reserved.
//

#import "DetailViewController.h"
#import "StoryModel.h"

@interface DetailViewController () <UICollectionViewDataSource, UICollisionBehaviorDelegate>
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

}


#pragma mark - Managing the detail item

- (void)setDetailStory:(id)newDetailStory {
    if (_detailStory != newDetailStory) {
        _detailStory = newDetailStory;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailStory) {
        self.detailDescriptionLabel.text = [self.detailStory description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


@end
