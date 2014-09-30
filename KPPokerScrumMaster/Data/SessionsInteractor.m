//
// Created by David Cumming on 30/09/2014.
// Copyright (c) 2014 Kotikan. All rights reserved.
//

#import "SessionsInteractor.h"
#import "AWSDynamoDBObjectMapper.h"
#import "SessionsTable.h"
#import "SessionModel.h"


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
    BFTask *currentStoryQuery = [sessionsTable fetchSessionsWithSessionId:@"1"];
    [currentStoryQuery
            continueWithExecutor:[BFExecutor mainThreadExecutor] withSuccessBlock:^id(BFTask *task) {
        if (task.error) {
            NSLog(@"%@", task.error.localizedDescription);
        } else {
            AWSDynamoDBPaginatedOutput *paginatedOutput = task.result;
            NSArray *sessions = [self sessionModelsFromItems:paginatedOutput.items];
            [_delegate setSessions:sessions];
        }
        return nil;
    }];

}

- (NSArray *)sessionModelsFromItems:(NSArray *)items {
    NSMutableArray *sessions = [NSMutableArray new];
    for (Session *session in items) {
        SessionModel *sessionModel = [[SessionModel alloc] init];
        sessionModel.sessionId  = session.sessionId;
        sessionModel.personId = session.personId;
        [sessions addObject:sessionModel];
    }
    return sessions;
}

@end