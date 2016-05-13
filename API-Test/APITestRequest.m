//
//  APITestRequest.m
//  API-Test
//
//  Created by Ilja Rozhko on 13.05.16.
//  Copyright © 2016 IR Works. All rights reserved.
//

#import "APITestRequest.h"

@implementation APITestRequest

- (id)initWithCallback:(void (^)(NSString *, NSDictionary *, NSError *))callbackHandler withURL:(NSString *)url withMethod:(NSString *)method {
    self = [self initWithURL:url withMethod:method withParameters:nil];
    [self setDebug:NO];
    [self setDelegate:self];
    
    callback = [callbackHandler copy];
    
    return self;
}

- (void)onRequestPrepared {
    
}

- (void)onRequestStarted {
    
}

- (void)onRequestPaused {
    
}

- (void)onRequestResumed {
    
}

- (void)onRequestCanceled {
    
}

- (void)onRequestSuccess:(NSString *)responseSting withJSON:(NSDictionary *)responseJSON {
    NSLog(@"ResponseJSON: %@", responseJSON);
    callback(responseSting, responseJSON, nil);
}

- (void)onRequestFail:(NSError *)error {
    callback(nil, nil, error);
}

@end
