//
// Created by David Cumming on 30/09/2014.
// Copyright (c) 2014 Kotikan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BaseScore : NSObject

@property (nonatomic, assign) NSString *storyId;
@property (nonatomic, assign) NSString *personId;
@property (nonatomic, assign) NSString *score;

-(instancetype)initWithStoryId:(NSString *)storyId personId:(NSString *)personId score:(NSString *)score;

@end