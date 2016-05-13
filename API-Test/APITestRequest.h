//
//  APITestRequest.h
//  API-Test
//
//  Created by Ilja Rozhko on 13.05.16.
//  Copyright © 2016 IR Works. All rights reserved.
//

#import "HTTPRequest.h"


typedef void (^CompletionBlock)(NSString *, NSDictionary *, NSError *);
@interface APITestRequest : HTTPRequest <HTTPRequestDelegate> {
    CompletionBlock callback;
}

- (id)initWithCallback:(void (^)(NSString *, NSDictionary *, NSError *))callbackHandler withURL:(NSString *)url withMethod:(NSString *)method;

@end
