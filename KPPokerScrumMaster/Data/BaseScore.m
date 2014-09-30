//
// Created by David Cumming on 30/09/2014.
// Copyright (c) 2014 Kotikan. All rights reserved.
//

#import "BaseScore.h"


@implementation BaseScore {

}

-(instancetype)initWithStoryId:(NSString *)storyId personId:(NSString *)personId score:(NSString *)score {

    if (self = [super init]){
        _storyId = storyId;
        _personId = personId;
        _score = score;
    }

    return self;
}

@end