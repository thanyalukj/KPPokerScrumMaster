//
// Created by David Cumming on 30/09/2014.
// Copyright (c) 2014 Kotikan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ScoreInteracting

- (void)setScores:(NSArray *)scores;

@end

@interface ScoreInteractor : NSObject

@property (nonatomic, weak) id <ScoreInteracting> delegate;
@property (nonatomic) NSString *storyId;
- (instancetype)initWithStoryId:(NSString *)storyId;

- (void)start;

@end