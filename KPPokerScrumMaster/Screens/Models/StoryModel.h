//
// Created by David Cumming on 30/09/2014.
// Copyright (c) 2014 Kotikan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StoryModel : NSObject
@property (nonatomic) NSString *title;
@property (nonatomic) NSDate *date;
@property (nonatomic) NSMutableArray *userCards;
@end