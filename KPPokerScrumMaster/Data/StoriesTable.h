//
// Created by David Cumming on 29/09/2014.
// Copyright (c) 2014 Kotikan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AWSDynamoDBObjectMapper.h"


@interface StoriesTable : NSObject

- (BFTask *)fetchStoryWithStoryId:(NSString *)storyId;

- (BFTask *)insertStoryWithStoryId:(NSString *)storyId score:(NSString *)score;
@end

@interface Story : AWSDynamoDBModel <AWSDynamoDBModeling>

@property (nonatomic, assign) NSString *storyId;
@property (nonatomic, assign) NSString *score;

@end