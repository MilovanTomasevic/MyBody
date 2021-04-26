//
//  IshranaMasterViewController.m
//  MyBody
//
//  Created by Milovan Tomasevic on 05/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "IshranaMasterViewController.h"

@interface IshranaMasterViewController ()

@end

@implementation IshranaMasterViewController{
    AppDelegate *appDelegate;
    int currentPage;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.coreDataManager = [[CoreDataManager alloc]init];
    self.ishranaDB = [self.coreDataManager getNewIshrana];
    
    currentPage = 0;
    
    [self loadScrollView];
    
    [self addChildViewController:[[PoViewController alloc]init]];
    [self addChildViewController:[[UtViewController alloc]init]];
    [self addChildViewController:[[SrViewController alloc]init]];
    [self addChildViewController:[[CeViewController alloc]init]];
    [self addChildViewController:[[PeViewController alloc]init]];
    [self addChildViewController:[[SuViewController alloc]init]];
    [self addChildViewController:[[NeViewController alloc]init]];
    
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

- (void)addIshranaSaveDone
{
    
    [self.coreDataManager addOrUpdateInshranaName:self.ishranaDB.ime forUserEmail:self.ishranaDB.userID datumUnosa:self.ishranaDB.datumUnosa vremeDorucka:self.ishranaDB.vremeDorucka vremeUzine:self.ishranaDB.vremeUzine vremeRucka:self.ishranaDB.vremeRucka vremeDrugeUzine:self.ishranaDB.vremeUzine2 vremeVecere:self.ishranaDB.vremeVecere pDorucak:self.ishranaDB.pDorucak pUzina:self.ishranaDB.pUzina pRucak:self.ishranaDB.pRucak pUzina2:self.ishranaDB.pUzina2 pVecera:self.ishranaDB.pVecera uDorucak:self.ishranaDB.uDorucak uUzina:self.ishranaDB.uUzina uRucak:self.ishranaDB.uRucak uUzina2:self.ishranaDB.uUzina2 uVecera:self.ishranaDB.uVecera sDorucak:self.ishranaDB.sDorucak sUzina:self.ishranaDB.sUzina sRucak:self.ishranaDB.sRucak sUzina2:self.ishranaDB.sUzina2 sVecera:self.ishranaDB.sVecera cDorucak:self.ishranaDB.cDorucak cUzina:self.ishranaDB.cUzina cRucak:self.ishranaDB.cRucak cUzina2:self.ishranaDB.cUzina2 cVecera:self.ishranaDB.cVecera peDorucak:self.ishranaDB.petDorucak peUzina:self.ishranaDB.petUzina peRucak:self.ishranaDB.petRucak peUzina2:self.ishranaDB.petUzina2 peVecera:self.ishranaDB.petVecera suDorucak:self.ishranaDB.subDorucak suUzina:self.ishranaDB.subUzina suRucak:self.ishranaDB.subRucak suUzina2:self.ishranaDB.subUzina2 suVecera:self.ishranaDB.subVecera nDorucak:self.ishranaDB.nDorucak nUzina:self.ishranaDB.nUzina nRucak:self.ishranaDB.nRucak nUzina2:self.ishranaDB.nUzina2 nVecera:self.ishranaDB.nVecera izabrana:self.ishranaDB.izabranaIshrana];
    
    [appDelegate saveContext];
    [MTSupport progressDone:@"Ishrana kreirana." andView:self.navigationController.view];
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
