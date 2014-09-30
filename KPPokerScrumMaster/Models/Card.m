//
// Created by Thanyaluk on 29/09/2014.
// Copyright (c) 2014 Kotikan. All rights reserved.
//

#import "Card.h"


@implementation Card

- (instancetype)initWithContent:(NSString *)content {
    self = [super init];
    if (self) {
        _content = content;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.content forKey:@"content"];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.content = [coder decodeObjectForKey:@"content"];
    return self;
}

@end