//
//  ThuyEarthquake.h
//  ThuysApp
//
//  Created by Thuy Hoang on 9/25/14.
//  Copyright (c) 2014 Thuy Hoang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThuyEarthquake : NSObject

@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *depth;
@property (nonatomic, strong) NSNumber *quality;
@property (nonatomic, strong) NSNumber *size;
@property (nonatomic, strong) NSString *humanReadableLocation;

+ (ThuyEarthquake *)earthquakeFromDictionary:(NSDictionary *)dict;
+ (NSArray *)earthquakeFromArray:(NSArray *)array;

@end
