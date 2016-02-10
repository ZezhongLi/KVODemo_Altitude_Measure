//
//  LocationData.m
//  LatLonAlti
//
//  Created by lee Neil on 2/2/16.
//  Copyright © 2016 lee Neil. All rights reserved.
//

#import "LocationData.h"

@implementation LocationData

- (id)initWithLat:(CLLocationDegrees)lat Lon:(CLLocationDegrees)lon Alti:(CLLocationDistance)alti {
    if (self = [super init]) {
        _lat = lat;
        _lon = lon;
        _alti = alti;
    }
    return self;
}


@end
