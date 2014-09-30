//
// Created by David Cumming on 29/09/2014.
// Copyright (c) 2014 Kotikan. All rights reserved.
//

#import "StoriesTable.h"


@implementation StoriesTable {

}

- (BFTask *)fetchStoryWithStoryId:(NSString *)storyId {
    AWSDynamoDBObjectMapper *dynamoDBObjectMapper = [AWSDynamoDBObjectMapper defaultDynamoDBObjectMapper];
    AWSDynamoDBQueryExpression *expression = [AWSDynamoDBQueryExpression new];
    expression.hashKeyValues = storyId;
    expression.rangeKeyConditions = nil;
    return [dynamoDBObjectMapper query:[Story class] expression:expression];
}

- (BFTask *)insertStoryWithStoryId:(NSString *)storyId score:(NSString *)score {
    Story *story = [Story new];
    story.storyId = storyId;
    story.score = score;
    AWSDynamoDBObjectMapper *dynamoDBObjectMapper = [AWSDynamoDBObjectMapper defaultDynamoDBObjectMapper];
    return [dynamoDBObjectMapper save:story];
}

@end


@implementation Story

+ (NSString *)dynamoDBTableName {
    return @"Stories";
}

+ (NSString *)hashKeyAttribute {
    return @"storyId";
}

+ (NSString *)rangeKeyAttribute {
    return nil;
}

@end