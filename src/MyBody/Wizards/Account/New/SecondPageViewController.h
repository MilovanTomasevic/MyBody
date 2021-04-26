//
//  SecondPageViewController.h
//  MyBody
//
//  Created by Milovan Tomasevic on 03/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "BasePageViewController.h"
#import "MTTextField.h"

@interface SecondPageViewController : BasePageViewController


@property (nonatomic, strong) MTFansyTextField *imeField;
@property (nonatomic, strong) MTFansyTextField *prezimeField;
@property (nonatomic, strong) MTFansyTextField *adresaField;
@property (nonatomic, strong) MTFansyTextField *gradField;
@property (nonatomic, strong) MTFansyTextField *pKodField;


@end
