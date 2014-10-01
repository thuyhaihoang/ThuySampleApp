//
//  ThuyBaseServiceHelper.h
//  ThuysApp
//
//  Created by Thuy Hoang on 9/25/14.
//  Copyright (c) 2014 Thuy Hoang. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Defining success block type for services.
 *
 *  @param  responseJSON    The service response.  Should alway be a NSDictionary
 */
typedef void (^ ServiceSuccessBlock)(NSDictionary *responseJSON);

@interface ThuyBaseServiceHelper : NSObject {

@private
    // Tracks active requests so they can be cancelled on dealloc
    __strong    NSMutableArray  *_activeRequests;
    
@protected
    __strong    MKNetworkEngine *_engine;
    
}

@property (nonatomic, readonly) MKNetworkEngine *engine;

// Request Management
- (void) addActiveRequest: (MKNetworkOperation *) request;
- (void) removeActiveRequest: (MKNetworkOperation *) request;

// Error Handling
- (BOOL) isValidResponse: (MKNetworkOperation *) operation;
- (NSError *) extractErrorFromResponseDict: (NSDictionary *) responseDict;
- (void) defaultErrorAlert: (NSError *) error;

// Convenience Methods
- (MKNetworkOperation *) emptyGetRequestWithPath: (NSString *) path;

@end
