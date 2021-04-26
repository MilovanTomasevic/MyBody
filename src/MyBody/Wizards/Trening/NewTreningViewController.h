//
//  NewTreningViewController.h
//  MyBody
//
//  Created by Milovan Tomasevic on 03/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTGradientProgressView.h"

@interface NewTreningViewController : UIViewController<UITextViewDelegate>{
    MTGradientProgressView *progressViewTop, *progressViewDown;
}

@property (strong, nonatomic) MTFansyTextView *tvTrening;
@property (strong, nonatomic) UIBarButtonItem *helpTrening;

@property (strong, nonatomic) MTFansyTextField *imeTreninga;
@property (strong, nonatomic) MTFansyTextField *datum;
@property (strong, nonatomic) MTFansyTextField *freeDay;
@property (strong, nonatomic) MTFansyTextField *emptyField;

@end
