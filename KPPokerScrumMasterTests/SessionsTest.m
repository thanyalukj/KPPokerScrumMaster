//
//  SessionsTest.m
//  PlanningAWS
//
//  Created by David Cumming on 29/09/2014.
//  Copyright (c) 2014 Kotikan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SessionsTable.h"

@interface SessionsTest : XCTestCase

@end

@implementation SessionsTest

-(void)testFetchSessionsWithSessionId {
    XCTestExpectation *commsComplete = [self expectationWithDescription:@"complete"];

    SessionsTable *sessionsTable = [[SessionsTable alloc]init];
    BFTask *currentStoryQuery = [sessionsTable fetchSessionsWithSessionId:@"newSessionId"];
    [currentStoryQuery
            continueWithExecutor:[BFExecutor mainThreadExecutor] withSuccessBlock:^id(BFTask *task) {
        if (task.error) {
            XCTAssertTrue(FALSE);
        } else {
            AWSDynamoDBPaginatedOutput *paginatedOutput = task.result;
            XCTAssertEqual(2, paginatedOutput.items.count);
        }
        [commsComplete fulfill];
        return nil;
    }];

    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
    }];
}

-(void)testInsertSessionWithSessionId {
    XCTestExpectation *commsComplete = [self expectationWithDescription:@"complete"];

    SessionsTable *sessionsTable = [[SessionsTable alloc]init];
    BFTask *insertQuery = [sessionsTable insertSessionWithSessionId:@"newSessionId" personId:@"newPersonId"];
    BFTask *insertQuery2 = [sessionsTable insertSessionWithSessionId:@"newSessionId" personId:@"newPersonId2"];

    [[BFTask taskForCompletionOfAllTasks:@[insertQuery, insertQuery2]]
            continueWithExecutor:[BFExecutor mainThreadExecutor] withBlock:^id(BFTask *task) {
        if (task.error) {
            NSLog(task.error.localizedDescription);
            XCTAssertTrue(FALSE);
        } else {
            XCTAssertTrue(TRUE);
        }
        [commsComplete fulfill];
        return nil;
    }];

    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        NSLog(@"done");
    }];
}

@end
