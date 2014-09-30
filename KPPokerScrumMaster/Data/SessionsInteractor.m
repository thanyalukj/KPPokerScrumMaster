//
// Created by David Cumming on 30/09/2014.
// Copyright (c) 2014 Kotikan. All rights reserved.
//

#import "SessionsInteractor.h"
#import "AWSDynamoDBObjectMapper.h"
#import "SessionsTable.h"


@implementation SessionsInteractor {
    NSString *_sessionId;
}

- (instancetype)initWithSessionId:(NSString *)sessionId {
    if (self = [super init]){
        _sessionId = sessionId;
    }
    return self;
}


- (void)start {
    SessionsTable *sessionsTable = [[SessionsTable alloc]init];
    BFTask *currentStoryQuery = [sessionsTable fetchSessionsWithSessionId:@"newSessionId"];
    [currentStoryQuery
            continueWithExecutor:[BFExecutor mainThreadExecutor] withSuccessBlock:^id(BFTask *task) {
        if (task.error) {
            NSLog(task.error.localizedDescription);
        } else {
            AWSDynamoDBPaginatedOutput *paginatedOutput = task.result;
            NSArray *sessions = (Session *)paginatedOutput.items;
            [_delegate setSessions:sessions];
        }
        return nil;
    }];

}

@end