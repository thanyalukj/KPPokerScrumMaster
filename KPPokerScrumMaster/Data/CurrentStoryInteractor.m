//
// Created by David Cumming on 30/09/2014.
// Copyright (c) 2014 Kotikan. All rights reserved.
//

#import <Bolts/BFExecutor.h>
#import "CurrentStoryInteractor.h"
#import "BFTask.h"
#import "CurrentStoryTable.h"


@implementation CurrentStoryInteractor {
    NSString *_sessionId;
    NSString *_currentStory;
}

- (instancetype)initWithSessionId:(NSString *)sessionId currentStory:(NSString *)currentStory {
    if (self = [super init]){
        _sessionId = sessionId;
        _currentStory = currentStory;
    }
    return self;
}

- (void)start {
    CurrentStoryTable *currentStoryTable = [[CurrentStoryTable alloc]init];
    BFTask *insertQuery = [currentStoryTable insertCurrentStoryWithSessionId: _sessionId storyId: _currentStory];
    [[BFTask taskForCompletionOfAllTasks:@[insertQuery]]
            continueWithExecutor:[BFExecutor mainThreadExecutor] withBlock:^id(BFTask *task) {
        if (task.error) {
            NSLog(task.error.localizedDescription);
        } else {
        }
        return nil;
    }];
}

@end