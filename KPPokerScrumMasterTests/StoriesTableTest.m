//
//  StoriesTableTest.m
//  PlanningAWS
//
//  Created by David Cumming on 29/09/2014.
//  Copyright (c) 2014 Kotikan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "StoriesTable.h"
#import "BFTask.h"
#import "BFExecutor.h"
#import "AWSDynamoDBObjectMapper.h"

@interface StoriesTableTest : XCTestCase

@end

@implementation StoriesTableTest

- (void)testFetchStoryWithStoryId {

    XCTestExpectation *commsComplete = [self expectationWithDescription:@"complete"];

    StoriesTable *storiesTable = [[StoriesTable alloc]init];
    BFTask *currentStoryQuery = [storiesTable fetchStoryWithStoryId:@"storyId"];
    [currentStoryQuery
            continueWithExecutor:[BFExecutor mainThreadExecutor] withSuccessBlock:^id(BFTask *task) {
        if (task.error) {
            XCTAssertTrue(FALSE);
        } else {
            AWSDynamoDBPaginatedOutput *paginatedOutput = task.result;
            Story *story = paginatedOutput.items.firstObject;
            XCTAssertTrue([story.score isEqualToString:@"score"]);
        }
        [commsComplete fulfill];
        return nil;
    }];

    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
    }];

}


- (void)testInsertStoryWithStoryId {
    XCTestExpectation *commsComplete = [self expectationWithDescription:@"complete"];

    StoriesTable *storiesTable = [[StoriesTable alloc]init];
    BFTask *insertQuery = [storiesTable insertStoryWithStoryId:@"storyId" score:@"score"];
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
