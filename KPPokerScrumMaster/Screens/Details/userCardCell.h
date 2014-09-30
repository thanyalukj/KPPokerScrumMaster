//
//  UserCardCell.h
//  KPPokerScrumMaster
//
//  Created by Thanyaluk on 29/09/2014.
//  Copyright (c) 2014 Kotikan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserCard;
@class SessionModel;
@class BaseSession;

@interface UserCardCell : UICollectionViewCell
@property (nonatomic) UserCard *userCard;
@property (nonatomic) BaseSession *session;
@end
