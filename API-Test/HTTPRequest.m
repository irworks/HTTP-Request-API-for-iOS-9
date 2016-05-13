//
//  HTTPRequest.m
//  API-Test
//
//  Created by Ilja Rozhko on 13.05.16.
//  Copyright © 2016 IR Works. All rights reserved.
//

#import "HTTPRequest.h"

@implementation HTTPRequest
@synthesize delegate;

- (id)initWithURL:(NSString *)urlString withMethod:(NSString *)method withParameters:(NSDictionary *)parameters {
    return [self initWithURL:urlString withCachePolicy:NSURLRequestReloadIgnoringLocalCacheData withTimeout:60.0 withMethod:method withParameters:parameters];
}

- (id)initWithURL:(NSString *)urlString withCachePolicy:(NSURLRequestCachePolicy)cachePolicy withTimeout:(NSTimeInterval)timeout withMethod:(NSString *)method withParameters:(NSDictionary *)parameters {
    self = [super init];
    
    //init the request
    request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString] cachePolicy:cachePolicy timeoutInterval:timeout];
    
    //check if parameter
    if(parameters == nil) {
        parameters = [[NSDictionary alloc] init];
    }
    
    //set method, header and parameter 
    [request setHTTPMethod:method];
    [request setValue:@"application/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[[self buildParameterStringFromDictionary:parameters] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [delegate onRequestPrepared];
    
    return self;
}

/* start, pause, cancel methods */

- (void)startRequest {
    //start the connection
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
                             
    dataSession = [session dataTaskWithRequest:request];
    [dataSession resume];
    [delegate onRequestStarted];
}

- (void)pauseRequest {
    [dataSession suspend];
    [delegate onRequestPaused];
}

- (void)resumeRequest {
    [dataSession resume];
    [delegate onRequestResumed];
}

- (void)cancelRequest {
    [dataSession cancel];
    [delegate onRequestCanceled];
}


/* DELEGATE METHODS */

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    
    if(error != nil) {
        if(_debug) {
            NSLog(@"Request #%lu failed: (%@)", (unsigned long)[task taskIdentifier], [error localizedDescription]);
        }
        
        [delegate onRequestFail:error];
    }
    
    if(_debug) {
        NSLog(@"%@", [task response]);
    }
    
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    
    NSError *error;
    
    NSString *responseString   = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    [delegate onRequestSuccess:responseString withJSON:responseDict];
}

/* Util method to build request string */
- (NSString *)buildParameterStringFromDictionary:(NSDictionary *)dict {
    NSString *parameterString = @"";
    
    for(NSString *key in dict) {
        NSString *seperator = REQUEST_NORMAL_SPERATOR;
        
        if([parameterString length] <= 0) {
            seperator = REQUEST_FIRST_SPERATOR;
        }
        
        parameterString = [NSString stringWithFormat:@"%@%@%@%@%@", parameterString, seperator, key, REQUEST_VALUE_SPERATOR, [dict valueForKey:key]];
    }
    
    return parameterString;
}

@end