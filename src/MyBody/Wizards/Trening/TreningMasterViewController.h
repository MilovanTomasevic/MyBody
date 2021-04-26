//
//  MasterViewController.h
//  MyBody
//
//  Created by Milovan Tomasevic on 03/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PonViewController.h"
#import "UtoViewController.h"
#import "SreViewController.h"
#import "CetViewController.h"
#import "PetViewController.h"
#import "SubViewController.h"
#import "NedViewController.h"
#import "Trening+CoreDataClass.h"
#import "CoreDataManager.h"

@interface TreningMasterViewController : UIViewController

@property (nonatomic, strong)CoreDataManager *coreDataManager;
@property (nonatomic, strong)Trening *treningDB;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

- (void)nextButtonPressed;
-(void)customBackButtonPressed;

- (void)addTreningSaveDone;

@end
