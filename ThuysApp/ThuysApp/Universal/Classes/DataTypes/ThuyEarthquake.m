//
//  ThuyEarthquake.m
//  ThuysApp
//
//  Created by Thuy Hoang on 9/25/14.
//  Copyright (c) 2014 Thuy Hoang. All rights reserved.
//

#import "ThuyEarthquake.h"

@implementation ThuyEarthquake

static NSString *timestampKey = @"timestamp";
static NSString *latitudeKey = @"latitude";
static NSString *longitudeKey = @"longitude";
static NSString *depthKey = @"depth";
static NSString *qualityKey = @"quality";
static NSString *sizeKey = @"size";
static NSString *humanReadableLocationKey = @"humanReadableLocation";

+ (ThuyEarthquake *)earthquakeFromDictionary:(NSDictionary *)dict {
    ThuyEarthquake *earthquake = [[ThuyEarthquake alloc] init];
    
    earthquake.timestamp = [dict objectForKey:timestampKey];
    earthquake.latitude = [dict objectForKey:latitudeKey];
    earthquake.longitude = [dict objectForKey:longitudeKey];
    earthquake.depth = [dict objectForKey:depthKey];
    earthquake.quality = [dict objectForKey:qualityKey];
    earthquake.size = [dict objectForKey:sizeKey];
    earthquake.humanReadableLocation = [dict objectForKey:humanReadableLocationKey];
    
    return earthquake;
}

+ (NSArray *)earthquakeFromArray:(NSArray *)array {
    if (array == nil) {
        return @[];
    }
    
    NSMutableArray *earthquakes = [[NSMutableArray alloc] initWithCapacity:[array count]];
    
    for (NSDictionary *earthQuakeDict in array) {
        [earthquakes addObject:[self earthquakeFromDictionary:earthQuakeDict]];
    }
    
    return earthquakes;

}

@end
