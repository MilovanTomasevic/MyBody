//
//  MasterViewController.m
//  MyBody
//
//  Created by Milovan Tomasevic on 03/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "TreningMasterViewController.h"

#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "LoginViewController.h"


@interface TreningMasterViewController ()

@end


@implementation TreningMasterViewController{
    AppDelegate *appDelegate;
    int currentPage;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.coreDataManager = [[CoreDataManager alloc]init];
    self.treningDB = [self.coreDataManager getNewTrening];
    
    currentPage = 0;
    
    [self loadScrollView];
    
    [self addChildViewController:[[PonViewController alloc]init]];
    [self addChildViewController:[[UtoViewController alloc]init]];
    [self addChildViewController:[[SreViewController alloc]init]];
    [self addChildViewController:[[CetViewController alloc]init]];
    [self addChildViewController:[[PetViewController alloc]init]];
    [self addChildViewController:[[SubViewController alloc]init]];
    [self addChildViewController:[[NedViewController alloc]init]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [THEME_MANAGER getAccentColor]}];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.view addSubview:[self.childViewControllers objectAtIndex:currentPage].view];
}

-(void)customBackButtonPressed{
    
    [self.view endEditing:YES];
    int page = currentPage;
    
    if (page == 0){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [[self.childViewControllers objectAtIndex:page].view removeFromSuperview];
        [self.view addSubview:[self.childViewControllers objectAtIndex:page-1].view];
        currentPage = page-1;
    }
}

- (void)nextButtonPressed {
    int page = currentPage;
    
    CGRect frame = _scrollView.frame;
    frame.origin.x = frame.size.width * (page+1);
    frame.origin.y = 0;
    
    [_scrollView scrollRectToVisible:frame animated:YES];
    
    [[self.childViewControllers objectAtIndex:page].view removeFromSuperview];
    [self.view addSubview:[self.childViewControllers objectAtIndex:page+1].view];
    currentPage = page+1;
}



- (void)addTreningSaveDone
{
    [self.coreDataManager addOrUpdateTreningName:self.treningDB.ime forUserEmail:self.treningDB.userID  datumUnosa:self.treningDB.datumUnosa  t1:self.treningDB.t1Sadrzaj  t2:self.treningDB.t2Sadrzaj  t3:self.treningDB.t3Sadrzaj  t4:self.treningDB.t4Sadrzaj  t5:self.treningDB.t5Sadrzaj  t6:self.treningDB.t6Sadrzaj  t7:self.treningDB.t7Sadrzaj  f1:self.treningDB.t1Fokus  f2:self.treningDB.t2Fokus  f3:self.treningDB.t3Fokus  f4:self.treningDB.t4Fokus  f5:self.treningDB.t5Fokus  f6:self.treningDB.t6Fokus  f7:self.treningDB.t7Fokus izabran:self.treningDB.izabraniTrening];
    [appDelegate saveContext];
    [MTSupport progressDone:@"Trening kreiran" andView:self.navigationController.view];
}


- (void)loadScrollView{
    CGRect frame = CGRectMake( 0, 0, self.view.frame.size.width, self.view.frame.size.height-1);
    self.scrollView= [[UIScrollView alloc] initWithFrame:frame];
    _scrollView.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    [_scrollView setBackgroundColor: [THEME_MANAGER getBackgroundColor]];
    [_scrollView setUserInteractionEnabled:YES];
    [_scrollView setScrollEnabled:YES];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:_scrollView];
}

@end
