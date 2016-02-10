//
//  LLATableViewCell.m
//  LatLonAlti
//
//  Created by lee Neil on 2/3/16.
//  Copyright © 2016 lee Neil. All rights reserved.
//

#import "LLATableViewCell.h"

@implementation LLATableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cell {
    return [[NSBundle mainBundle]loadNibNamed:@"LLATableViewCell" owner:nil options:nil][0];
}

@end
