//
// Created by David Cumming on 29/09/2014.
// Copyright (c) 2014 Kotikan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AWSDynamoDBObjectMapper.h"


@interface ScoreTable : NSObject

- (BFTask *)fetchScoresWithStoryId:(NSString *)storyId;

- (BFTask *)insertScoreWithStoryId:(NSString *)storyId personId:(NSString *)personId scoreValue:(NSString *)scoreValue;

@end

@interface Score : AWSDynamoDBModel <AWSDynamoDBModeling>

@property (nonatomic, assign) NSString *storyId;
@property (nonatomic, assign) NSString *personId;
@property (nonatomic, assign) NSString *score;

@end