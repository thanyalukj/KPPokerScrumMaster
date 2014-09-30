//
// Created by Thanyaluk on 29/09/2014.
// Copyright (c) 2014 Kotikan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Card : NSObject <NSCoding>

@property (nonatomic) NSString *content;

- (id)initWithContent:(NSString *)content;

@end