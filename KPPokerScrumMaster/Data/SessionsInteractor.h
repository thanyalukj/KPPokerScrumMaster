//
// Created by David Cumming on 30/09/2014.
// Copyright (c) 2014 Kotikan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SessionsInteracting

- (void)setSessions:(NSArray *)sessions;

@end

@interface SessionsInteractor : NSObject

@property (nonatomic, weak) id <SessionsInteracting>delegate;

- (instancetype)initWithSessionId:(NSString *)sessionId;

@end