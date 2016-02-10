//
//  LLATableViewCell.h
//  LatLonAlti
//
//  Created by lee Neil on 2/3/16.
//  Copyright © 2016 lee Neil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLATableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *locInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *hdistance;
@property (weak, nonatomic) IBOutlet UILabel *vdistance;

+ (instancetype)cell;

@end
