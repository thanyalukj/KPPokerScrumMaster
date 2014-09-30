//
// Created by David Cumming on 29/09/2014.
// Copyright (c) 2014 Kotikan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AWSDynamoDBObjectMapper.h"


@class CurrentStory;
@class BFTask;

@interface CurrentStoryTable : NSObject

- (BFTask *)fetchCurrentStoryWithSessionId:(NSString *)sessionId;

- (BFTask *)insertCurrentStoryWithSessionId:(NSString *)sessionId storyId:(NSString *)storyId;

@end

@interface CurrentStory : AWSDynamoDBModel <AWSDynamoDBModeling>

@property (nonatomic, assign) NSString *sessionId;
@property (nonatomic, assign) NSString *storyId;

@end