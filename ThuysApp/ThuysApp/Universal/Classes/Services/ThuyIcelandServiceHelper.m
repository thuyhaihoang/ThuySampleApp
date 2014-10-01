//
//  ThuyIcelandServiceHelper.m
//  ThuysApp
//
//  Created by Thuy Hoang on 9/25/14.
//  Copyright (c) 2014 Thuy Hoang. All rights reserved.
//

#import "ThuyIcelandServiceHelper.h"
#import "ThuyLottery.h"
#import "ThuyEarthquake.h"

@interface ThuyIcelandServiceHelper()

- (void) sendDelegateError: (NSError *) error forServiceType: (ThuyIcelandServiceType) serviceType;

- (void) runOperation: (MKNetworkOperation *) operation
     withSuccessBlock: (ServiceSuccessBlock) successBlock
       andServiceType: (ThuyIcelandServiceType) serviceType;

@end

@implementation ThuyIcelandServiceHelper

#pragma mark - Initializers

/**
 *  Initializer with delegate.
 *
 *  @param  delegate    The writer event delegate.
 *
 *  @return WriterServiceHelper
 */
- (id) initWithDelegate: (id<ThuyIcelandServiceDelegate>) delegate{
    self = [self init];
    if (self != nil) {
        _delegate = delegate;
    }
    
    return self;
}

#pragma mark - Services

- (void)allLotteries {
    MKNetworkOperation *operation = [self emptyGetRequestWithPath:@"/lottery"];
    
    ServiceSuccessBlock successBlock = ^(NSDictionary *responseJSON){
        NSArray *lotteries = [responseJSON objectForKey:@"results"];
        
        if ([self.delegate respondsToSelector:@selector(gotLotteries:)]) {
            [self.delegate gotLotteries:[ThuyLottery lotteryFromArray:lotteries]];
        }
    };
    
    [self runOperation:operation withSuccessBlock:successBlock andServiceType:ThuyIcelandServiceLotteries];
}

- (void)allEarthquakes {
    MKNetworkOperation *operation = [self emptyGetRequestWithPath:@"/earthquake/is"];
    
    ServiceSuccessBlock successBlock = ^(NSDictionary *responseJSON){
        NSArray *earthquakes = [responseJSON objectForKey:@"results"];
        
        if ([self.delegate respondsToSelector:@selector(gotEarthquakes:)]) {
            [self.delegate gotEarthquakes:[ThuyEarthquake earthquakeFromArray:earthquakes]];
        }
    };
    
    [self runOperation:operation withSuccessBlock:successBlock andServiceType:ThuyIcelandEarthquakes];
}

#pragma mark - Helpers
/**
 *  Sends the error to the delegate
 *
 *  @param  error   The error
 *  @param  serviceType The service type
 */
- (void)sendDelegateError:(NSError *)error forServiceType: (ThuyIcelandServiceType) serviceType {
    if ([self.delegate respondsToSelector:@selector(icelandServiceType:failedWithError:)]) {
        [self.delegate icelandServiceType:serviceType failedWithError:error];
    }
}

/**
 *  This runs all requests and performs the given success block if the response is valid.
 *
 *  @param  operation       The network operation to run.
 *  @param  successBlock    The success block to run if the response is valid.
 *  @param  serviceType     The service type being run.
 */
- (void) runOperation: (MKNetworkOperation *) operation
     withSuccessBlock: (ServiceSuccessBlock) successBlock
       andServiceType: (ThuyIcelandServiceType) serviceType{
    
    @try {
        
        if ([self.delegate respondsToSelector:@selector(icelandServiceDidStart:)]) {
            [self.delegate icelandServiceDidStart:serviceType];
        }
        
        [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            
            NSDictionary *responseDict = completedOperation.responseJSON;
            
            if ([self isValidResponse:completedOperation]) {
                successBlock(responseDict);
            } else {
                [self sendDelegateError:[self extractErrorFromResponseDict:responseDict]
                         forServiceType:serviceType];
            }
            
            [self removeActiveRequest:completedOperation];
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            
            if (error.code == 403) {
                NSLog(@"Do something");
            } else {
                [self sendDelegateError:error forServiceType:serviceType];
            }
            
            
            [self removeActiveRequest:completedOperation];
        }];
        
        [self addActiveRequest:operation];
        [self.engine enqueueOperation:operation];
    }@catch (NSException *exception) {
        
    }
    
}


@end
