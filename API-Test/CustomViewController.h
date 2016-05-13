//
//  CustomViewController.h
//  API-Test
//
//  Created by Ilja Rozhko on 13.05.16.
//  Copyright © 2016 IR Works. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SIDE_MARGIN 10
#define ITEM_MARGIN 15
#define BACKGROUND_COLOR [UIColor colorWithRed:0.02 green:0.012 blue:0.078 alpha:1] /*#050314*/
#define WHITE_COLOR [UIColor colorWithRed:0.988 green:0.988 blue:0.988 alpha:1] /*#fcfaf4*/

@interface CustomViewController : UIViewController {
    UIScrollView *mainScrollView;
    float yPos;

}

- (UITextField *)addTextFieldToMainView:(UITextField *)textField withTitle:(BOOL)titleLbl withTitleText:(NSString *) titleText withPlaceholder:(NSString *) placeholder;
- (UIButton *)addButtonToMainView:(UIButton *)button withTitleText:(NSString *) titleText;
- (UITextView *)addTextviewToMainView:(UITextView *)textView withText:(NSString *) text;

@end
