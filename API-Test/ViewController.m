//
//  ViewController.m
//  API-Test
//
//  Created by Ilja Rozhko on 13.05.16.
//  Copyright © 2016 IR Works. All rights reserved.
//

#import "ViewController.h"

#import "APITestRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"API-Test";
    [self buildCustomUI];
    [self loadLastValues];
}

- (void)buildCustomUI {
    requestURLField    = [self addTextFieldToMainView:requestURLField withTitle:YES withTitleText:@"API request URL" withPlaceholder:@"https://api.example.com/1.1/endpoint"];
    requestMethodField = [self addTextFieldToMainView:requestURLField withTitle:YES withTitleText:@"API request method (POST, GET)" withPlaceholder:@"POST"];
    
    submitButton       = [self addButtonToMainView:submitButton withTitleText:@"Send Request"];
    [submitButton      addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    resultTextView     = [self addTextviewToMainView:resultTextView withText:@"n/a"];
}

- (void)loadLastValues {
    [requestURLField setText:[[NSUserDefaults standardUserDefaults] stringForKey:@"lastRequestURL"]];
    [requestMethodField setText:[[NSUserDefaults standardUserDefaults] stringForKey:@"lastRequestMethod"]];
}

- (void)saveLastValues {
    [[NSUserDefaults standardUserDefaults] setValue:[requestURLField text] forKey:@"lastRequestURL"];
    [[NSUserDefaults standardUserDefaults] setValue:[requestMethodField text] forKey:@"lastRequestMethod"];
}

- (void)submitButtonPressed:(id)sender {
    
    [self saveLastValues];
    
    APITestRequest *apiTestRequest = [[APITestRequest alloc] initWithCallback:^(NSString *responseString, NSDictionary *responseDict, NSError *error) {
        NSLog(@"response %@", responseString);
        
        if(error != nil) {
            [resultTextView setText:[error localizedDescription]];
            return;
        }
        
        if(responseDict != nil) {
            [resultTextView setText:[NSString stringWithFormat:@"%@", responseDict]];
            return;
        }
        
        [resultTextView setText:responseString];
        
    } withURL:[requestURLField text] withMethod:[requestMethodField text]];
    
    [apiTestRequest startRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
