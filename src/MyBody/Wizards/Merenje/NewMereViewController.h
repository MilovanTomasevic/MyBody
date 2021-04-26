//
//  NewMereViewController.h
//  MyBody
//
//  Created by Milovan Tomasevic on 01/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTGradientProgressView.h"
#import "NYSegmentedControl.h"
#import "CoreDataManager.h"

@class MTGradientProgressView;

@interface NewMereViewController : UIViewController<UITextFieldDelegate>{
    MTGradientProgressView *progressViewTop, *progressViewDown;
}

@property (nonatomic, strong)CoreDataManager *coreDataManager;
@property (nonatomic, strong)Mere *mereDB;

@property (strong, nonatomic) MTFansyTextField *imeMerenja;
@property (strong, nonatomic) MTFansyTextField *datum;
@property (strong, nonatomic) MTFansyTextField *visina;
@property (strong, nonatomic) MTFansyTextField *tezina;
@property (strong, nonatomic) MTFansyTextField *pol;
@property (strong, nonatomic) MTFansyTextField *godine;
@property (strong, nonatomic) MTFansyTextField *obimKuka;
@property (strong, nonatomic) MTFansyTextField *obimGrudi;
@property (strong, nonatomic) MTFansyTextField *obimButina;
@property (strong, nonatomic) MTFansyTextField *kratkaNapomena;
@property (strong, nonatomic) MTFansyTextField *emptyField;
@property (strong, nonatomic) MTFansyTextField *BMI;

@property (nonatomic, strong) UIButton *btnBMI;
@property (strong, nonatomic) UIBarButtonItem *helpBMI;

@property (strong, nonatomic) NYSegmentedControl *switchSegmentedControl;

@end
