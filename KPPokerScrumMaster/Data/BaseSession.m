//
// Created by David Cumming on 30/09/2014.
// Copyright (c) 2014 Kotikan. All rights reserved.
//

#import "BaseSession.h"


@implementation BaseSession {

}

-(instancetype)initWithSessionId:(NSString *)sessionId personId:(NSString *) personId {
    if (self = [super init]){
        _sessionId = sessionId;
        _personId = personId;
    }

    return self;
}

@end