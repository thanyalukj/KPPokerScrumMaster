//
// Created by David Cumming on 30/09/2014.
// Copyright (c) 2014 Kotikan. All rights reserved.
//

#import "ScoreInteractor.h"
#import "AWSDynamoDBObjectMapper.h"
#import "ScoreTable.h"


@implementation ScoreInteractor {
    NSString *_storyId;
}

- (instancetype)initWithStoryId:(NSString *)storyId {
    if (self = [super init]){
        _storyId = storyId;
    }
    return self;
}

- (void)start {
    ScoreTable *scoreTable = [[ScoreTable alloc]init];
    BFTask *currentStoryQuery = [scoreTable fetchScoresWithStoryId:_storyId];
    [currentStoryQuery
            continueWithExecutor:[BFExecutor mainThreadExecutor] withSuccessBlock:^id(BFTask *task) {
        if (task.error) {
            NSLog(task.error.localizedDescription);
        } else {
            AWSDynamoDBPaginatedOutput *paginatedOutput = task.result;
            NSArray *scores = (Score *)paginatedOutput.items;
            [_delegate setScores:scores];
        }
        return nil;
    }];
}

@end