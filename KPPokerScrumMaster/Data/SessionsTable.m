//
// Created by David Cumming on 29/09/2014.
// Copyright (c) 2014 Kotikan. All rights reserved.
//

#import <sys/proc.h>
#import "SessionsTable.h"


@implementation SessionsTable {

}

- (BFTask *)fetchSessionsWithSessionId:(NSString *)sessionId {
    AWSDynamoDBObjectMapper *dynamoDBObjectMapper = [AWSDynamoDBObjectMapper defaultDynamoDBObjectMapper];
    AWSDynamoDBQueryExpression *expression = [AWSDynamoDBQueryExpression new];
    expression.hashKeyValues = sessionId;
    expression.rangeKeyConditions = nil;
    return [dynamoDBObjectMapper query:[Session class] expression:expression];
}

- (BFTask *)insertSessionWithSessionId:(NSString *)sessionId personId:(NSString *)personId {
    Session *session = [Session new];
    session.sessionId = sessionId;
    session.personId = personId;

    AWSDynamoDBObjectMapper *dynamoDBObjectMapper = [AWSDynamoDBObjectMapper defaultDynamoDBObjectMapper];
    return [dynamoDBObjectMapper save:session];
}

@end

@implementation Session

+ (NSString *)dynamoDBTableName {
    return @"Sessions";
}

+ (NSString *)hashKeyAttribute {
    return @"sessionId";
}

+ (NSString *)rangeKeyAttribute {
    return @"personId";
}


@end