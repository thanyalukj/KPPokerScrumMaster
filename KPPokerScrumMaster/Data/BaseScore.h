//
// Created by David Cumming on 30/09/2014.
// Copyright (c) 2014 Kotikan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BaseScore : NSObject

@property (nonatomic, copy) NSString *storyId;
@property (nonatomic, copy) NSString *personId;
@property (nonatomic, copy) NSString *score;

- (instancetype)initWithStoryId:(NSString *)storyId personId:(NSString *)personId score:(NSString *)score;

@end