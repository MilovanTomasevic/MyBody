//
//  ViewController.m
//  MyBody
//
//  Created by Milovan Tomasevic on 29/10/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "ViewController.h"
#import "UIFloatLabelTextField.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[UIFloatLabelTextField appearance] setBackgroundColor:[UIColor yellowColor]];
    
    UIFloatLabelTextField *firstNameTextField = [UIFloatLabelTextField new];
    firstNameTextField.frame = CGRectMake(50, 30, 100, 50);
    [firstNameTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    firstNameTextField.floatLabelActiveColor = [UIColor orangeColor];
    firstNameTextField.placeholder = @"First Name";
    firstNameTextField.text = @"Test";
    firstNameTextField.backgroundColor = [UIColor redColor];
    //firstNameTextField.layer.cornerRadius = 7;
    //firstNameTextField.delegate = self;
    //[firstNameTextField addTarget:self action:@selector(addLeftIcon) forControlEvents:UIControlEventAllEvents];
    [self.view addSubview:firstNameTextField];
}



@end
