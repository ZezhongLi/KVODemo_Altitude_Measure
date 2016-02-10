//
//  LocationData.h
//  LatLonAlti
//
//  Created by lee Neil on 2/2/16.
//  Copyright © 2016 lee Neil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LocationData : NSObject
@property (nonatomic, assign) CLLocationDegrees lat;
@property (nonatomic, assign) CLLocationDegrees lon;
@property (nonatomic, assign) CLLocationDistance alti;

- (id)initWithLat:(CLLocationDegrees)lat Lon:(CLLocationDegrees)lon Alti:(CLLocationDistance)alti;

@end
