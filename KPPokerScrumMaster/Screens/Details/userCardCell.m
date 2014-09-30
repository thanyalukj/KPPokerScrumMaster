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

@implementation UserCardCell {    
    __weak IBOutlet UILabel *_userLabel;
    __weak IBOutlet UIImageView *_cardImageView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setUserCard:(UserCard *)userCard {
    _userCard = userCard;
    _userLabel.text = _userCard.username;
    NSString *imageName = [NSString stringWithFormat:@"card_%@", @"?"];
    _cardImageView.image = [UIImage imageNamed:imageName];
}

@end
