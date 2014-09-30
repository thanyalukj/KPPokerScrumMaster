//
// Created by Thanyaluk on 30/09/2014.
// Copyright (c) 2014 Kotikan. All rights reserved.
//

#import "StoryTableViewCell.h"

@interface StoryTableViewCell ()
@property (nonatomic) UILabel *label;
@end

@implementation StoryTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryView = self.label;
    }
    return self;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 21)];
        _label.textAlignment = NSTextAlignmentRight;
    }
    return _label;
}

- (void)setScore:(NSString *)score {
    _score = score;
    self.label.text = score;
    self.accessoryView = self.label;
}

@end