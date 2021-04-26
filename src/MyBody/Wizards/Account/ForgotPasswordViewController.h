//
//  ForgotPasswordViewController.h
//  MyBody
//
//  Created by Milovan Tomasevic on 06/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User+CoreDataClass.h"
#import "CoreDataManager.h"

@interface ForgotPasswordViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong)CoreDataManager *coreDataManager;
@property (nonatomic, strong)User *user;

@property (nonatomic, strong) MTFansyTextField *mailField;
@property (nonatomic, strong) MTFansyTextField *brojTelField;
@property (nonatomic, strong) MTFansyTextField *sPitanjeField;
@property (nonatomic, strong) MTFansyTextField *sOdgovorField;

@end
