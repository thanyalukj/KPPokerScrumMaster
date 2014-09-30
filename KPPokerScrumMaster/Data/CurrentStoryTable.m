//
// Created by David Cumming on 29/09/2014.
// Copyright (c) 2014 Kotikan. All rights reserved.
//

#import <Bolts/BFExecutor.h>
#import "CurrentStoryTable.h"

@interface CurrentStoryTable ()

@end


@implementation CurrentStoryTable

- (BFTask *)fetchCurrentStoryWithSessionId:(NSString *)sessionId {
    AWSDynamoDBObjectMapper *dynamoDBObjectMapper = [AWSDynamoDBObjectMapper defaultDynamoDBObjectMapper];
    AWSDynamoDBQueryExpression *expression = [AWSDynamoDBQueryExpression new];
    expression.hashKeyValues = sessionId;
    expression.rangeKeyConditions = nil;
    return [dynamoDBObjectMapper query:[CurrentStory class] expression:expression];
}

- (BFTask *)insertCurrentStoryWithSessionId:(NSString *)sessionId storyId:(NSString *)storyId {
    CurrentStory *currentStory = [CurrentStory  new];
    currentStory.sessionId = sessionId;
    currentStory.storyId = storyId;
    AWSDynamoDBObjectMapper *dynamoDBObjectMapper = [AWSDynamoDBObjectMapper defaultDynamoDBObjectMapper];
    return [dynamoDBObjectMapper save:currentStory];
}

@end

@implementation CurrentStory

+ (NSString *)dynamoDBTableName {
    return @"CurrentStory";
}

+ (NSString *)hashKeyAttribute {
    return @"sessionId";
}

+ (NSString *)rangeKeyAttribute {
    return nil;
}

@end
