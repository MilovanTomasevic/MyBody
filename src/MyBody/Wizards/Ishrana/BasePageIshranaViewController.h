//
//  BasePageIshranaViewController.h
//  MyBody
//
//  Created by Milovan Tomasevic on 05/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTGradientProgressView.h"
#import "NYSegmentedControl.h"

@interface BasePageIshranaViewController : UIViewController{
    MTGradientProgressView *progressViewTop, *progressViewDown;
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (strong, nonatomic) UISegmentedControl *pControl;

@property (strong, nonatomic) MTFansyTextView *tvDorucak;
@property (strong, nonatomic) MTFansyTextView *tvUzina;
@property (strong, nonatomic) MTFansyTextView *tvRucak;
@property (strong, nonatomic) MTFansyTextView *tvUzina2;
@property (strong, nonatomic) MTFansyTextView *tvVecera;

@property (strong, nonatomic) MTFansyTextField *vremeDFiled;
@property (strong, nonatomic) MTFansyTextField *vremeUFiled;
@property (strong, nonatomic) MTFansyTextField *vremeRFiled;
@property (strong, nonatomic) MTFansyTextField *vremeU2Filed;
@property (strong, nonatomic) MTFansyTextField *vremeVFiled;

-(void)segmentSwitch;


@end
