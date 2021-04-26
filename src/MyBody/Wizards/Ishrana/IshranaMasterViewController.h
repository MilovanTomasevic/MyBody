//
//  IshranaMasterViewController.h
//  MyBody
//
//  Created by Milovan Tomasevic on 05/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PoViewController.h"
#import "UtViewController.h"
#import "SrViewController.h"
#import "CeViewController.h"
#import "PeViewController.h"
#import "SuViewController.h"
#import "NeViewController.h"
#import "Ishrana+CoreDataClass.h"
#import "CoreDataManager.h"

@interface IshranaMasterViewController : UIViewController

@property (nonatomic, strong)CoreDataManager *coreDataManager;
@property (nonatomic, strong)Ishrana *ishranaDB;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

- (void)nextButtonPressed;
-(void)customBackButtonPressed;

- (void)addIshranaSaveDone;
@end
