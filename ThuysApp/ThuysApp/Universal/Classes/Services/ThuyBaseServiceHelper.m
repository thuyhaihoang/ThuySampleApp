//
//  ThuyBaseServiceHelper.m
//  ThuysApp
//
//  Created by Thuy Hoang on 9/25/14.
//  Copyright (c) 2014 Thuy Hoang. All rights reserved.
//

#import "ThuyBaseServiceHelper.h"

@interface ThuyBaseServiceHelper()

- (MKNetworkOperation *) emptyBaseRequestWithPath: (NSString *) path method: (NSString *) method andParams: (NSDictionary *) params;
- (NSDictionary *) contentTypeHeaders;

@end

@implementation ThuyBaseServiceHelper

#pragma mark - Lifecycle Managment

- (id) init{
    if ( self = [super init] ) {
        _activeRequests = [[NSMutableArray alloc] init];
        _engine = [[MKNetworkEngine alloc] initWithHostName:@"apis.is"];
    }
    return self;
}

- (void) dealloc {
    
    // Cancel any asynchronous requests still working
    for (MKNetworkOperation *request in _activeRequests){
        //[request clearDelegatesAndCancel];
        [request cancel];
    }
    
}


#pragma mark - Request Management


/**
 *  Adds an active request to the active requests array
 *
 *  @param  request The request to add
 */
- (void) addActiveRequest: (MKNetworkOperation *) request {
    
    [_activeRequests addObject: request];
    
}



/**
 *  Removes an active request to the active requests array
 *
 *  @param  request The request to remove
 */
- (void) removeActiveRequest: (MKNetworkOperation *) request {
    [_activeRequests removeObject: request];
}



#pragma mark - Error Handling


- (BOOL) isValidResponse: (MKNetworkOperation *) operation {
    
    // If we didn't get a status code back assume correct
    NSString *opResponseString = operation.responseString;
    NSString *httpMethod = operation.readonlyRequest.HTTPMethod.uppercaseString;
    if ([httpMethod isEqualToString:@"GET"] || opResponseString.length == 0) {
        return YES;
    }
    
    NSDictionary *responseDict = operation.responseJSON;
    
    return [[responseDict objectForKey:@"status_code"] integerValue] == 1;
    
}

- (NSError *) extractErrorFromResponseDict: (NSDictionary *) responseDict {
    
    if (responseDict) {
        if ([responseDict objectForKey:@"message"]) {
            NSError *error = [[NSError alloc] initWithDomain:[[NSBundle mainBundle] bundleIdentifier]
                                                        code:42
                                                    userInfo:@{NSLocalizedDescriptionKey: [responseDict objectForKey: @"message"]}];
            
            return error;
        }
        return nil;
    } else {
        NSMutableDictionary *errorDetails = [[NSMutableDictionary alloc] init];
        [errorDetails setValue:@"Error occurred when extracting error message." forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"error" code:200 userInfo:errorDetails];
        return error;
    }
}

- (void) defaultErrorAlert:(NSError *)error {
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error")
                                message:error.localizedDescription
                               delegate:nil
                      cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                      otherButtonTitles: nil] show];
}

#pragma mark - Convenience Methods

/**
 *  Convenience method to get a new http request with no request method set and the content headers set for json.
 *
 *  @return MKNetworkOperation  The empty request.
 */
- (MKNetworkOperation *) emptyBaseRequestWithPath:(NSString *)path method:(NSString *)method andParams:(NSDictionary *)params{
    
    
    MKNetworkOperation  *operation = [self.engine operationWithPath:path
                                                             params:params
                                                         httpMethod:method
                                                                ssl:NO];
    
    operation.postDataEncoding = MKNKPostDataEncodingTypeJSON;
    
    [operation addHeaders:[self contentTypeHeaders]];
    
    return operation;
    
}

/**
 *  Convenience method to get a new http get request with the content headers set for json.
 *
 *  @return MKNetworkOperation  The empty request.
 */
- (MKNetworkOperation *) emptyGetRequestWithPath: (NSString *) path {
    MKNetworkOperation  *operation = [self emptyBaseRequestWithPath:path method:@"GET" andParams:nil];
    
    return operation;
}

/**
 *  Gets the content type headers for the operations
 *
 *  @return NSDicationary
 */
- (NSDictionary *) contentTypeHeaders{
    return @{@"Accept": @"application/json"};
}


@end
