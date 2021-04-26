//
//  FirstPageViewController.h
//  MyBody
//
//  Created by Milovan Tomasevic on 03/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "BasePageViewController.h"
#import "MTTextField.h"

@interface FirstPageViewController : BasePageViewController


@property (nonatomic, strong) MTTextField *emailField;
@property (nonatomic, strong) MTTextField *passwordField;
@property (nonatomic, strong) MTTextField *passwordRepeatField;



@end
