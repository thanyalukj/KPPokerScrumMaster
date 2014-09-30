//
//  CurrentStoryTableTest.m
//  PlanningAWS
//
//  Created by David Cumming on 29/09/2014.
//  Copyright (c) 2014 Kotikan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AWSDynamoDBObjectMapper.h"
#import "CurrentStoryTable.h"


@interface CurrentStoryTableTest : XCTestCase

@end

@implementation CurrentStoryTableTest {
}

- (void)testFetchCurrentStoryWithSessionId {

    XCTestExpectation *commsComplete = [self expectationWithDescription:@"complete"];

    CurrentStoryTable *currentStoryTable = [[CurrentStoryTable alloc]init];
    BFTask *currentStoryQuery = [currentStoryTable fetchCurrentStoryWithSessionId:@"newSessionID"];
    [currentStoryQuery
            continueWithExecutor:[BFExecutor mainThreadExecutor] withSuccessBlock:^id(BFTask *task) {
        if (task.error) {
            XCTAssertTrue(FALSE);
        } else {
            AWSDynamoDBPaginatedOutput *paginatedOutput = task.result;
            CurrentStory *currentStory = paginatedOutput.items.firstObject;
            XCTAssertTrue([currentStory.storyId isEqualToString:@"newCurrentStory"]);
        }
        [commsComplete fulfill];
        return nil;
    }];

    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
    }];

}

- (void)testInsertCurrentStory {
    XCTestExpectation *commsComplete = [self expectationWithDescription:@"complete"];

    CurrentStoryTable *currentStoryTable = [[CurrentStoryTable alloc]init];
    BFTask *insertQuery = [currentStoryTable insertCurrentStoryWithSessionId: @"newSessionID" storyId: @"newCurrentStory"];
    [[BFTask taskForCompletionOfAllTasks:@[insertQuery]]
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
