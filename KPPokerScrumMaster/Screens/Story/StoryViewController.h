//
//  CreateStoryViewController.h
//  KPPokerScrumMaster
//
//  Created by Thanyaluk on 29/09/2014.
//  Copyright (c) 2014 Kotikan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StoryViewController;
@class Story;

@protocol StoryViewControllerDelegate
- (void)storyViewController:(StoryViewController *)viewController storyCreated:(Story *)story;
@end

@interface StoryViewController : UIViewController

@property (nonatomic, weak) id<StoryViewControllerDelegate>delegate;
@end
