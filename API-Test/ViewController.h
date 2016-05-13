//
//  ViewController.h
//  API-Test
//
//  Created by Ilja Rozhko on 13.05.16.
//  Copyright © 2016 IR Works. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomViewController.h"

@interface ViewController : CustomViewController {
    UITextField *requestURLField;
    UITextField *requestMethodField;
    UIButton *submitButton;
    UITextView *resultTextView;
}


@end

