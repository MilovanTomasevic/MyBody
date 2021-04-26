//
//  ThirdPageViewController.h
//  MyBody
//
//  Created by Milovan Tomasevic on 03/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "BasePageViewController.h"
#import "MTTextField.h"

@interface ThirdPageViewController : BasePageViewController

@property (nonatomic, strong) MTFansyTextField *telefonField;
@property (nonatomic, strong) MTFansyTextField *sPitanje;
@property (nonatomic, strong) MTFansyTextField *sOdgovorField;

@property (nonatomic, strong) UIButton *btnSelection;


@end
