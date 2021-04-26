//
//  PonViewController.m
//  MyBody
//
//  Created by Milovan Tomasevic on 03/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "PonViewController.h"
#import "TreningMasterViewController.h"

@interface PonViewController (){
    TreningMasterViewController *masterVC;
}


@end

@implementation PonViewController{
    AppDelegate *appDelegate;
    CoreDataManager *coreDataManager;
    Trening *treningDataBase;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    coreDataManager = [[CoreDataManager alloc]init];
    treningDataBase = [coreDataManager getNewTrening];
    
    masterVC = (TreningMasterViewController*)self.parentViewController;
    
    self.currentText = [[NSString alloc]init];
    self.currentText = @"prazan";

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    UIBarButtonItem* backButton = [[UIBarButtonItem alloc] initWithTitle:@">"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(customBackButtonPressed)];
    backButton.title=@"<";
    UIButton* insertData = [MTButton createNavBarButton:NSLocalizedString(@"MT data", nil)];
    [insertData addTarget:self action:@selector(insertData) forControlEvents:UIControlEventTouchUpInside];
    self.inData = [[UIBarButtonItem alloc] initWithCustomView:insertData];
    masterVC.navigationItem.leftBarButtonItems = @[backButton,self.inData];
    
    
    masterVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@">"
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(nextPage)];
    
    masterVC.navigationItem.title = @"Ponedeljak";
    //self.tvTrening.placeholder = @"Trening za ponedeljak:";

    self.pControl.selectedSegmentIndex = 0;

    [self segmentSwitch];
    [self segmentSwitchYesNo];
    
    if (![_currentText isEqualToString:@"prazan"]) {
        self.tvTrening.text = self.currentText;
    }
}

- (IBAction)segmentSwitch:(UISegmentedControl *)sender {
    
    [self segmentSwitchYesNo];
}



-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [self nextPage];
}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [self customBackButtonPressed];
}

-(void)customBackButtonPressed
{
    [masterVC customBackButtonPressed];
}

-(void)nextPage
{
    LogI(@"Next button clicked u ponedeljku");
    
    //trim string from edit text
    self.tvTrening.text = [self.tvTrening.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.fokusTreningIme.text = [self.fokusTreningIme.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([self.tvTrening.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_21",nil)];
        return;
    }
    if([self.fokusTreningIme.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_21a",nil)];
        return;
    }
    [masterVC.treningDB setT1Fokus:self.fokusTreningIme.text];
    [masterVC.treningDB setT1Sadrzaj:self.tvTrening.text];
    self.currentText = masterVC.treningDB.t1Sadrzaj;
    LogI(@" setovani trening za ponedeljak:   %@", masterVC.treningDB.t1Sadrzaj);
    
    [masterVC nextButtonPressed];
}



-(void)insertData{
    
    [ALERT_PRESENTER presentAlertControllerWithConfigurationHandler:^(MTAlertDescriptor * descriptor) {
        descriptor.priority = MTAlertPriorityNormal;
        descriptor.title = NSLocalizedString(@"MT data", nil);
        descriptor.message = NSLocalizedString(@"Ukoliko zelite da vidite test podatke, moj trenig, pritisnite Insert.", nil);
        descriptor.cancelTitle = NSLocalizedString(@"Cancel", nil);
        descriptor.otherTitles = @[NSLocalizedString(@"Insert", nil)];
        [descriptor setTapBlock:^(UIAlertController *controller, UIAlertAction *action, NSInteger buttonIndex) {
            if (buttonIndex != MTAlertBlocksCancelButtonIndex) {
                [self addedData];
            }else{
                [self goToBack];
            }
        }];
    }];
}

-(void)addedData{
    
    NSDateFormatter *today=[[NSDateFormatter alloc] init];
    [today setDateFormat:@"dd.MM.yyyy. HH:mm:ss"];
    NSString *currentDate = [today stringFromDate:[NSDate date]];
    NSString *userMail = [[NSUserDefaults standardUserDefaults] valueForKey:PREF_USER_EMAIL];
    
    [masterVC.treningDB setIme:@"Trening za kicmu i telo"];

    [masterVC.treningDB setT1Fokus:@"Vezbe snage"];
    [masterVC.treningDB setT1Sadrzaj:@"A1 - Bugarski Cucanj   12 x 4\nA2 - Propadanja   15 x 4\n\nB1 - Iskorak   20 x 4\nB2 - Zgib.   12 x 4\n\nC1 - Zadnja Loza   12 x 4\nC2 - Lat   12 x 4"];
    
    [masterVC.treningDB setT2Fokus:@"Kardio + vezbe za telo i kicmu"];
    [masterVC.treningDB setT2Sadrzaj:@"30-45min trcanje\n\nCat Camel   12 x 1 - poza\nBird Dog (bench)   10 x 3 - strunjaca - klupa\nSuperman   10 x 3 - jedna ruka\nFront Plank   8 x 3 - izdrzaj napred\nCylinder   10 x 3 - bočno\nHalfkneeling Pallof P    8 x 4 - guma strnjaca/stojeci\nBack Extention Holds   teg 8 sekundi"];
    
    [masterVC.treningDB setT3Fokus:@"Vezbe snage"];
    [masterVC.treningDB setT3Sadrzaj:@"A1 - Cucanj   15 x 4\nA2 - Benc pres 10 x 4\n\nB1 - Leg Pres   15 x 4 - noge\nB2 - Potisak za rame    10 x 4 - ramena klupa\n\nC1 - Nozna ekstenzija    15 x 3 noge napred guram\nC2 - Zgib    max x 3"];
    
    [masterVC.treningDB setT4Fokus:@"Kardio + vezbe za telo i kicmu"];
    [masterVC.treningDB setT4Sadrzaj:@"30-45min trcanje\n\nCat Camel   12 x 1\nBird Dog (bench)   10 x 3\nSuperman   10 x 3\nMcGill CurlUp   8 x 3 izdrzaj nazad\nOblique Hold   8 x 3 izdrzaj bočni\nKneeling Pallof P.   10 x 4"];
    
    [masterVC.treningDB setT5Fokus:@"Vezbe snage"];
    [masterVC.treningDB setT5Sadrzaj:@"A1 - Bugarski Cucanj   12 x 4\nA2 - Potisak na kosoj   12 x 4\n\nB1 - Cucanj   15 x 4\nB2 - Sklek   10 x 4 - (4-2-4)\n\nC1 - Zadnja Loza na podu   15 x 3 - dizanje kukovi, pete\nC2 - Zgib (Obrnut hvat)    12 x 3"];
    
    [masterVC.treningDB setT6Fokus:@"Kardio + vezbe za telo i kicmu"];
    [masterVC.treningDB setT6Sadrzaj:@"30-45min trcanje\n\nCat Camel   12 x 1\nBird Dog (bench)   10 x 3\nDeadBug   8 x 3 - strunjaca 2x90\nOblique Hold   8 x 3\nHalfkneeling Pallof P.   8 x 4\nBack Extention Holds"];
    
    [masterVC.treningDB setT7Fokus:@"Danasss... danas Bajo moj ne radim! 🙈🙉🙊🐷🐽"];
    [masterVC.treningDB setT7Sadrzaj:@"Danas delim savete za ishranu... 😂😂😂🍔🌮🍕🍺🍭🍦\n\n"];
    
    [masterVC.treningDB setDatumUnosa:currentDate];
    [masterVC.treningDB setUserID:userMail];
    
    
    [masterVC addTreningSaveDone];
    
    // set all defaults =  NO
    for (Trening *tre in  [coreDataManager getAllTreninge]) {
        [tre setIzabraniTrening:NO];
    }
    
    // set current mere for Default YES
    Trening *tre = [coreDataManager getTreningForName:masterVC.treningDB.ime];
    [tre setIzabraniTrening:YES];
    
    [appDelegate saveContext];
    
    [self goToBack];
    
}


-(void)goToBack{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}




@end
