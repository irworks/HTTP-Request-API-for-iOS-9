# HTTP-Request-API-for-iOS-9
Three classes for easy-to-use HTTP Requests in Objective-C using the NSURLSessions.

This project includes an example application, just compile and test.

## How to use the API  

**0)** Copy `HTTPRequestDelegate.h`, `HTTPRequest.h` and `HTTPRequest.m` into your project.

**1)** Subclass the `HTTPRequest` class and include the `HTTPRequestDelegate` delegate
    `@interface APITestRequest : HTTPRequest <HTTPRequestDelegate>`   
  
**2)** Implement the following methods:  
  `- (void)onRequestPrepared;`  
  `- (void)onRequestStarted;`  
  `- (void)onRequestPaused;`  
  `- (void)onRequestResumed;`  
  `- (void)onRequestCanceled;`  

  `- (void)onRequestSuccess:(NSString *)responseSting withJSON:(NSDictionary *)responseJSON;`  
  `- (void)onRequestFail:(NSError *)error;`   
  
**3)** Create your request by using:
`- (id)initWithURL:(NSString *)urlString withMethod:(NSString *)method withParameters:(NSDictionary *)parameters;`   
or   
`- (id)initWithURL:(NSString *)urlString withCachePolicy:(NSURLRequestCachePolicy)cachePolicy withTimeout:(NSTimeInterval)timeout withMethod:(NSString *)method withParameters:(NSDictionary *)parameters;`  

**4)** Start your request using:   
`- (void)startRequest;`

## Example:  
See the `APITestRequest` class.

## Optional:

`[self setDebug:YES];`   
`[self setDelegate:self];`
