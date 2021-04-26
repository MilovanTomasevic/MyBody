//
//  MasterViewController.m
//  MyBody
//
//  Created by Milovan Tomasevic on 03/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "MasterViewController.h"

#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "LoginViewController.h"


@interface MasterViewController ()

@end


@implementation MasterViewController{
    AppDelegate *appDelegate;
    int currentPage;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.coreDataManager = [[CoreDataManager alloc]init];
    self.user = [self.coreDataManager getNewUser];
    
    currentPage = 0;
    
    [self loadScrollView];
    
    [self addChildViewController:[[FirstPageViewController alloc]init]];
    [self addChildViewController:[[SecondPageViewController alloc]init]];
    [self addChildViewController:[[ThirdPageViewController alloc]init]];
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

- (void)addAccountSaveDone
{

    [self.coreDataManager addOrUpdateUserEmail:self.user.mail sifra:self.user.sifra ime:self.user.ime prezime:self.user.prezime adresa:self.user.adresa grad:self.user.grad postanskiKod:self.user.postanskiKod telefon:self.user.telefon sigurnosnoPitanje:self.user.sPitanje sigurnosniOdgovor:self.user.sOdgovor];
    
    [appDelegate saveContext];
    [MTSupport progressDone:@"Nalog kreiran" andView:self.navigationController.view];
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
