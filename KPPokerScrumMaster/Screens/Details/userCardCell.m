//
//  UserCardCell.m
//  KPPokerScrumMaster
//
//  Created by Thanyaluk on 29/09/2014.
//  Copyright (c) 2014 Kotikan. All rights reserved.
//

#import "UserCardCell.h"
#import "UserCard.h"
#import "Card.h"
#import "BaseSession.h"

@implementation UserCardCell {    
    __weak IBOutlet UILabel *_userLabel;
    __weak IBOutlet UIImageView *_cardImageView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSession:(BaseSession *)session {
    _session = session;
    _userLabel.text = _session.personId;
    _cardImageView.image = [UIImage imageNamed:@"card_small_timer"];
}

- (void)setScore:(NSString *)score {
    _score = score;
    if (_score) {
        NSString *imageName = [NSString stringWithFormat:@"card_%@", score];
        _cardImageView.image = [UIImage imageNamed:imageName];
    }
}

@end
