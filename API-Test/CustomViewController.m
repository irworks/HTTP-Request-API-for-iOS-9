//
//  CustomViewController.m
//  API-Test
//
//  Created by Ilja Rozhko on 13.05.16.
//  Copyright © 2016 IR Works. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController ()

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupMainUI];
}

- (void)setupMainUI {
    
    yPos = 10;
    
    mainScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [mainScrollView setScrollsToTop:YES];
    [mainScrollView setBackgroundColor:BACKGROUND_COLOR];
    
    [self.view addSubview:mainScrollView];
}

- (UITextField *)addTextFieldToMainView:(UITextField *)textField withTitle:(BOOL)titleLbl withTitleText:(NSString *) titleText withPlaceholder:(NSString *) placeholder{
    
    if(titleLbl) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SIDE_MARGIN, yPos, self.view.frame.size.width - SIDE_MARGIN*2, 15)];
        [titleLabel setText:titleText];
        [titleLabel setTextColor:WHITE_COLOR];
        [titleLabel setFont:[UIFont systemFontOfSize:14]];
        [mainScrollView addSubview:titleLabel];
        yPos += titleLabel.frame.size.height + ITEM_MARGIN/2;
    }
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(SIDE_MARGIN, yPos, self.view.frame.size.width - SIDE_MARGIN*2, 35)];
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    [textField setPlaceholder:placeholder];
    [textField setFont:[UIFont systemFontOfSize:16]];
    [textField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [mainScrollView addSubview:textField];
    
    yPos += textField.frame.size.height + ITEM_MARGIN;
    
        [textField addTarget:self
                      action:@selector(textFieldFinished:)
            forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [mainScrollView setContentSize:CGSizeMake(self.view.frame.size.width, yPos)];
    
    return textField;
}

- (UIButton *)addButtonToMainView:(UIButton *)button withTitleText:(NSString *) titleText {
    button = [[UIButton alloc] initWithFrame:CGRectMake(SIDE_MARGIN, yPos, self.view.frame.size.width - SIDE_MARGIN*2, 45)];
    
    [button setBackgroundColor:WHITE_COLOR];
    [button setTitleColor:BACKGROUND_COLOR forState:UIControlStateNormal];
    [[button layer] setCornerRadius:5];
    
    [button setTitle:titleText forState:UIControlStateNormal];
    [mainScrollView addSubview:button];
    
    yPos += button.frame.size.height + ITEM_MARGIN;
    
    return button;
}

- (UITextView *)addTextviewToMainView:(UITextView *)textView withText:(NSString *) text {
    textView = [[UITextView alloc] initWithFrame:CGRectMake(SIDE_MARGIN, yPos, self.view.frame.size.width - SIDE_MARGIN*2, 150)];
    
    [textView setText:text];
    [textView setTextColor:BACKGROUND_COLOR];
    [textView setBackgroundColor:WHITE_COLOR];
    [[textView layer] setCornerRadius:5];
    
    [mainScrollView addSubview:textView];
    
    yPos += textView.frame.size.height + ITEM_MARGIN;
    return textView;
}

- (IBAction)textFieldFinished:(id)sender {
    [sender resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
