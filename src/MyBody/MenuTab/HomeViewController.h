//
//  HomeViewController.h
//  MyBody
//
//  Created by Milovan Tomasevic on 29/10/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "NYSegmentedControl.h"
#import "CoreDataManager.h"

@interface HomeViewController : UIViewController <UITextFieldDelegate,UIPopoverControllerDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate, UISearchBarDelegate>


@property (strong, nonatomic) LoginViewController *loginVC;
@property (strong, nonatomic) NYSegmentedControl *segmentedControl;
@property (strong, nonatomic) UITableView * tableView;

@property (nonatomic, strong)CoreDataManager *coreDataManager;
@property (nonatomic, strong)Mere *dbMere;
@property (nonatomic, strong)Ishrana *dbIshrana;
@property (nonatomic, strong)Trening *dbTrening;

@end
