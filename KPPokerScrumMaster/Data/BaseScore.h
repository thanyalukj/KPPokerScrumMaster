//
// Created by David Cumming on 30/09/2014.
// Copyright (c) 2014 Kotikan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BaseScore : NSObject

@property (nonatomic) NSString *storyId;
@property (nonatomic) NSString *personId;
@property (nonatomic) NSString *score;

-(instancetype)initWithStoryId:(NSString *)storyId personId:(NSString *)personId score:(NSString *)score;

@end