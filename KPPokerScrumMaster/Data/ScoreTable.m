//
// Created by David Cumming on 29/09/2014.
// Copyright (c) 2014 Kotikan. All rights reserved.
//

#import "ScoreTable.h"


@implementation ScoreTable {

}

- (BFTask *)fetchScoresWithStoryId:(NSString *)storyId {
    AWSDynamoDBObjectMapper *dynamoDBObjectMapper = [AWSDynamoDBObjectMapper defaultDynamoDBObjectMapper];
    AWSDynamoDBQueryExpression *expression = [AWSDynamoDBQueryExpression new];
    expression.hashKeyValues = storyId;
    expression.rangeKeyConditions = nil;
    return [dynamoDBObjectMapper query:[Score class] expression:expression];
}

- (BFTask *)insertScoreWithStoryId:(NSString *)storyId personId:(NSString *)personId scoreValue:(NSString *)scoreValue {
    Score *score = [Score new];
    score.personId = personId;
    score.storyId = storyId;
    score.score = scoreValue;
    AWSDynamoDBObjectMapper *dynamoDBObjectMapper = [AWSDynamoDBObjectMapper defaultDynamoDBObjectMapper];
    return [dynamoDBObjectMapper save:score];
}

@end

@implementation Score

+ (NSString *)dynamoDBTableName {
    return @"Scores";
}

+ (NSString *)hashKeyAttribute {
    return @"storyId";
}

+ (NSString *)rangeKeyAttribute {
    return @"personId";
}

@end