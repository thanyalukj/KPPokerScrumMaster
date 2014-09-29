//
// Created by Thanyaluk on 29/09/2014.
// Copyright (c) 2014 Kotikan. All rights reserved.
//

#import "Story.h"
#import "UserCard.h"


@implementation Story

- (instancetype)init {
    self = [super init];
    if (self) {
        _userCards = [NSMutableArray new];
        [self createRandomUserCards];
    }
    return self;
}

- (void)createRandomUserCards {
    for (NSUInteger i=0; i<8; i++) {
        UserCard *userCard = [[UserCard alloc] init];
        userCard.username = [NSString stringWithFormat:@"user %d", i+1];
        userCard.card = nil;
        [self.userCards addObject:userCard];
    }
}

@end