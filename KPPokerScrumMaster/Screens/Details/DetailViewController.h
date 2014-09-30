//
//  DetailViewController.h
//  KPPokerScrumMaster
//
//  Created by Thanyaluk on 29/09/2014.
//  Copyright (c) 2014 Kotikan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StoryModel;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) StoryModel *detailStory;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

