//
// Created by David Cumming on 30/09/2014.
// Copyright (c) 2014 Kotikan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CurrentStoryInteractor : NSObject

- (instancetype)initWithSessionId:(NSString *)sessionId currentStory:(NSString *)currentStory;

- (void)start;

@end