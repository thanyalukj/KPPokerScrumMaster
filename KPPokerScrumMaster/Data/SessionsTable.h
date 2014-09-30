//
// Created by David Cumming on 29/09/2014.
// Copyright (c) 2014 Kotikan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AWSDynamoDBObjectMapper.h"


@interface SessionsTable : NSObject

-(BFTask *)fetchSessionsWithSessionId:(NSString *)sessionId;

-(BFTask *)insertSessionWithSessionId:(NSString *)sessionId personId:(NSString *)personId;

@end

@interface Session : AWSDynamoDBModel <AWSDynamoDBModeling>

@property (nonatomic, assign) NSString *sessionId;
@property (nonatomic, assign) NSString *personId;

@end