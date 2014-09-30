//
// Created by Thanyaluk on 29/09/2014.
// Copyright (c) 2014 Kotikan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Card;


@interface UserCard : NSObject

@property (nonatomic) NSString *username;
@property (nonatomic) Card *card;

@end