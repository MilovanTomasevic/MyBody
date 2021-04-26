//
//  BasePageViewController.h
//  MyBody
//
//  Created by Milovan Tomasevic on 03/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTGradientProgressView.h"
#import "NYSegmentedControl.h"

@interface BasePageTreningViewController : UIViewController<UITextViewDelegate>{
    MTGradientProgressView *progressViewTop, *progressViewDown;
}

//@property (nonatomic, strong) IBOutlet UIPageControl *pControl;

@property (strong, nonatomic) UISegmentedControl *pControl;
@property (strong, nonatomic) MTFansyTextField *freeDay;
@property (strong, nonatomic) MTFansyTextField *emptyField;
@property (strong, nonatomic) MTFansyTextField *fokusTreningIme;

@property (strong, nonatomic) NYSegmentedControl *switchSegmentedControl;
@property (strong, nonatomic) MTFansyTextView *tvTrening;

-(void)segmentSwitchYesNo;
-(void)segmentSwitch;


@end
