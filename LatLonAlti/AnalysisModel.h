//
//  AnalysisModel.h
//  LatLonAlti
//
//  Created by lee Neil on 2/3/16.
//  Copyright © 2016 lee Neil. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LocationData;
@interface AnalysisModel : NSObject
@property (nonatomic, strong) LocationData *locData;
@property (nonatomic, copy) NSString *userInput;
@property (nonatomic, assign) double horizontalDif;// compared to last location --- coordinate
@property (nonatomic, assign) double verticalDif;// compared to last location --- altitude
@end
