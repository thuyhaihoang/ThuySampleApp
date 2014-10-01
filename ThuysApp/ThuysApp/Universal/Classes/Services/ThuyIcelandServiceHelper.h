//
//  ThuyIcelandServiceHelper.h
//  ThuysApp
//
//  Created by Thuy Hoang on 9/25/14.
//  Copyright (c) 2014 Thuy Hoang. All rights reserved.
//

#import "ThuyBaseServiceHelper.h"

/**
 *  Iceland service types.
 */
typedef enum {
    ThuyIcelandServiceLotteries,
    ThuyIcelandEarthquakes
} ThuyIcelandServiceType;

/**
 *  Delegate protocol for resource service event handling.
 */
@protocol ThuyIcelandServiceDelegate <NSObject>


@required
/**
 *  Tells the delegate that there was a failure.
 *
 *  @param  serviceType     The service type.
 *  @param  error           The error.
 */
- (void) icelandServiceType:(ThuyIcelandServiceType)serviceType failedWithError: (NSError *) error;

- (void) icelandServiceDidStart:(ThuyIcelandServiceType)serviceType;

@optional

- (void)gotLotteries:(NSArray *)lotteries;
- (void)gotEarthquakes:(NSArray *)earthquakes;

@end

@interface ThuyIcelandServiceHelper : ThuyBaseServiceHelper

/** Delegate for authorization events. */
@property (weak, readonly) id<ThuyIcelandServiceDelegate>  delegate;

#pragma mark - Initializers
// Initializers
- (id) initWithDelegate: (id<ThuyIcelandServiceDelegate>) delegate;

#pragma mark - Services
- (void)allLotteries;
- (void)allEarthquakes;

@end
