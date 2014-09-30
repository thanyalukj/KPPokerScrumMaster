//
//  ScoreTableTest.m
//  PlanningAWS
//
//  Created by David Cumming on 29/09/2014.
//  Copyright (c) 2014 Kotikan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ScoreTable.h"

@interface ScoreTableTest : XCTestCase

@end

@implementation ScoreTableTest

- (void)testFetchScoresWithStoryId {
    XCTestExpectation *commsComplete = [self expectationWithDescription:@"complete"];

    ScoreTable *scoreTable = [[ScoreTable alloc]init];
    BFTask *currentStoryQuery = [scoreTable fetchScoresWithStoryId:@"storyId"];
    [currentStoryQuery
            continueWithExecutor:[BFExecutor mainThreadExecutor] withSuccessBlock:^id(BFTask *task) {
        if (task.error) {
            XCTAssertTrue(FALSE);
        } else {
            AWSDynamoDBPaginatedOutput *paginatedOutput = task.result;
            XCTAssertEqual([paginatedOutput.items count], 2);
        }
        [commsComplete fulfill];
        return nil;
    }];

    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
    }];
}

- (void)testInsertScoreWithStoryId {
    XCTestExpectation *commsComplete = [self expectationWithDescription:@"complete"];

    ScoreTable *scoreTable = [[ScoreTable alloc]init];
    BFTask *insertQuery = [scoreTable insertScoreWithStoryId:@"storyId" personId:@"personId" scoreValue:@"scoreValue"];
    BFTask *insertQuery2 = [scoreTable insertScoreWithStoryId:@"storyId" personId:@"anotherPersonId" scoreValue:@"anotherScoreValue"];
    [[BFTask taskForCompletionOfAllTasks:@[insertQuery]]
            continueWithExecutor:[BFExecutor mainThreadExecutor] withBlock:^id(BFTask *task) {
        if (task.error) {
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
