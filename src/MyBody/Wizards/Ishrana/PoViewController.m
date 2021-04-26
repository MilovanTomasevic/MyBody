//
//  PoViewController.m
//  MyBody
//
//  Created by Milovan Tomasevic on 05/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "PoViewController.h"
#import "IshranaMasterViewController.h"

#define kOFFSET_FOR_KEYBOARD 80.0

@interface PoViewController (){
    IshranaMasterViewController *masterVC;
}


@end

@implementation PoViewController{
    AppDelegate *appDelegate;
    CoreDataManager *coreDataManager;
    Ishrana *ishranaDataBase;

}

- (void)viewDidLoad {
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    coreDataManager = [[CoreDataManager alloc]init];
    ishranaDataBase = [coreDataManager getNewIshrana];
    
    masterVC = (IshranaMasterViewController*)self.parentViewController;
}



- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    masterVC.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithTitle:@"<"
//                                                                                style:UIBarButtonItemStylePlain
//                                                                               target:self
//                                                                               action:@selector(customBackButtonPressed)];
//
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
    self.pControl.selectedSegmentIndex = 0;
    
    [self segmentSwitch];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    

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
    self.tvDorucak.text = [self.tvDorucak.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.tvUzina.text = [self.tvUzina.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.tvRucak.text = [self.tvRucak.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.tvUzina2.text = [self.tvUzina2.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.tvVecera.text = [self.tvVecera.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([self.vremeDFiled.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_vreme_1",nil)];
        return;
    }
    
    if([self.tvDorucak.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_22",nil)];
        return;
    }
    
    if([self.vremeUFiled.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_vreme_2",nil)];
        return;
    }
    
    if([self.tvUzina.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_23",nil)];
        return;
    }
    
    if([self.vremeRFiled.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_vreme_3",nil)];
        return;
    }
    
    if([self.tvRucak.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_24",nil)];
        return;
    }
    
    if([self.vremeU2Filed.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_vreme_4",nil)];
        return;
    }
    
    if([self.tvUzina2.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_25",nil)];
        return;
    }
    
    if([self.vremeVFiled.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_vreme_5",nil)];
        return;
    }
    
    if([self.tvVecera.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_26",nil)];
        return;
    }
    
    [masterVC.ishranaDB setPDorucak:self.tvDorucak.text];
    [masterVC.ishranaDB setPUzina:self.tvUzina.text];
    [masterVC.ishranaDB setPRucak:self.tvRucak.text];
    [masterVC.ishranaDB setPUzina2:self.tvUzina2.text];
    [masterVC.ishranaDB setPVecera:self.tvVecera.text];
    
    [masterVC.ishranaDB setVremeDorucka:self.vremeDFiled.text];
    [masterVC.ishranaDB setVremeUzine:self.vremeUFiled.text];
    [masterVC.ishranaDB setVremeRucka:self.vremeRFiled.text];
    [masterVC.ishranaDB setVremeUzine2:self.vremeU2Filed.text];
    [masterVC.ishranaDB setVremeVecere:self.vremeVFiled.text];

    LogI(@" setovana ishrana za ponedeljak:   %@", masterVC.ishranaDB.pDorucak);
    LogI(@" setovana ishrana za ponedeljak:   %@", masterVC.ishranaDB.pUzina);
    LogI(@" setovana ishrana za ponedeljak:   %@", masterVC.ishranaDB.pRucak);
    LogI(@" setovana ishrana za ponedeljak:   %@", masterVC.ishranaDB.pUzina2);
    LogI(@" setovana ishrana za ponedeljak:   %@", masterVC.ishranaDB.pVecera);
    
    [masterVC nextButtonPressed];
}




-(void)insertData{
    
    [ALERT_PRESENTER presentAlertControllerWithConfigurationHandler:^(MTAlertDescriptor * descriptor) {
        descriptor.priority = MTAlertPriorityNormal;
        descriptor.title = NSLocalizedString(@"MT data", nil);
        descriptor.message = NSLocalizedString(@"Ukoliko zelite da vidite test podatke, moju ishranu za sve dane, pritisnite Insert.", nil);
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

    [masterVC.ishranaDB setIme:@"BMI-23 Normalno uhranjen - Bazalni metabolizam 1876kcal"];
    
    [masterVC.ishranaDB setVremeDorucka:@"8"];
    [masterVC.ishranaDB setVremeUzine:@"11"];
    [masterVC.ishranaDB setVremeRucka:@"14"];
    [masterVC.ishranaDB setVremeUzine2: @"17"];
    [masterVC.ishranaDB setVremeVecere:@"20"];

    [masterVC.ishranaDB setPDorucak:@"Integralni Tonus hleb 50g\nMlad sir 30g\nKefir 200ml"];
    [masterVC.ishranaDB setPUzina:@"Dinja i lubenica po 120g"];
    [masterVC.ishranaDB setPRucak:@"Pileće belo meso sa teflona 100g\nBareni int.pirinač 30g\nBareni brokoli 100g\nBaradajz I paprika po 70g"];
    [masterVC.ishranaDB setPUzina2:@"Lanene pločice 40g\nBonžita 30g"];
    [masterVC.ishranaDB setPVecera: @"Pileće belo meso bareno 50g\nBarena kinoa 40g\nZelena salata 50g\nKrastavac 50g"];

    [masterVC.ishranaDB setUDorucak:@"Integralni dvopek 50g\nBareno belance 2kom.\nParadajz 100g"];
    [masterVC.ishranaDB setUUzina:@"Kruška 200g"];
    [masterVC.ishranaDB setURucak:@"Barena junetina 90g\nBarena spelta 30g\nBarena boranija 100g\nCrveni kupus\nSargarepa I celer po 50g"];
    [masterVC.ishranaDB setUUzina2:@"Ovsene pločice 40g\nCrna čokolada 30g"];
    [masterVC.ishranaDB setUVecera: @"Integralne špagete 40g\nMlad sir 30g\nJogurt 200ml"];

    [masterVC.ishranaDB setSDorucak:@"Kačamak 50g\nMlad sir 30g\nJogurt 200ml"];
    [masterVC.ishranaDB setSUzina:@"Grožđe 180g"];
    [masterVC.ishranaDB setSRucak:@"Cureće belo meso bareno 100g\nBareni proso 30g\nBareni kukuruz i šargarepa po 30g\nParadajz I krastavac po 70g"];
    [masterVC.ishranaDB setSUzina2:@"Heljdine pločice 40g\nBonžita 30g"];
    [masterVC.ishranaDB setSVecera: @"Cureće belo meso bareno 50g\nBarena spelta 40g\nZelena salata 50g\nKrastavac 50g"];
    
    [masterVC.ishranaDB setCDorucak:@"Ovsene, ječmene i ražane pahulljice po 15g u kefiru 250ml"];
    [masterVC.ishranaDB setCUzina:@"Lešnik, badem I indijski orah po 20g"];
    [masterVC.ishranaDB setCRucak:@"Losos sa teflona 90g\nBarena kinoa 30g\nBareni grašak 70g\nSalata od šargarepe, celera i kupusa po 50g"];
    [masterVC.ishranaDB setCUzina2:@"Integralni keks 40g\nCrna čokolada 30g" ];
    [masterVC.ishranaDB setCVecera: @"Lignje sa teflona 60g\nBareni integralni pirinač 40g\nBaprika 100g"];
    
    [masterVC.ishranaDB setPetDorucak:@"Integralni Tonus hleb 50g\nBareno belance 2kom\nParadajz 100g"];
    [masterVC.ishranaDB setPetUzina:@"Ceđeni grejpfrut, narandža i limun 250ml"];
    [masterVC.ishranaDB setPetRucak:@"Pileći batak sa teflona 90g\nBareni amaranth 30g\nTikvice sa teflona 100g\nSalata od spanaća 130g\nBeli luk 2g"];
    [masterVC.ishranaDB setPetUzina2:@"Integralni dvopek 40g\nPekmez 30g"];
    [masterVC.ishranaDB setPetVecera: @"Integralne makarone 40g\nMlad sir 30g\nKefir 200ml"];

    
    [masterVC.ishranaDB setSubDorucak:@"Ovsena kaša 50g sa mlevenim lešnikom 20g I medom 30g"];
    [masterVC.ishranaDB setSubUzina:@"Banana 150g"];
    [masterVC.ishranaDB setSubRucak:@"Oslić sa teflona 120g\nBarena kinoa 30g\nPlavi patlidžan sa teflona 100g\nSalata od cvekle 100g I crvenog kupusa 50g"];
    [masterVC.ishranaDB setSubUzina2:@"Lanene pločice 40g\nVoćni jogurt 200ml"];
    [masterVC.ishranaDB setSubVecera: @"Mlevena junetina 40g\nIntegralne špagete 40g preliti paradajz sokom 200ml"];

    [masterVC.ishranaDB setNDorucak:@"Kačamak 50g\nMladi siro 30g\nKefir 200ml"];
    [masterVC.ishranaDB setNUzina:@"Breskva, šljiva i kajsija po 70g"];
    [masterVC.ishranaDB setNRucak:@"Barena junetina 90g\nBareni amaranth 30g\nSampinjoni sa teflona 100g\nKrastavac 100g I kupus 50g"];
    [masterVC.ishranaDB setNUzina2:@"Integralni dvopek 40g\nPekmez 30g"];
    [masterVC.ishranaDB setNVecera: @"Barena heljda 40g\nOslić baren 60g\nParadajz 100g \n\n\n-SVAKI DAN PRE RUČKA KONZUMIRATI ČORBU OD POVRĆA ( CRNI I BELI LUK, ZELEN, ŠARGAREPA,KROMPI, KUKURUZ... ) BEZ TESTENINA I BEZ POVRĆA, 200ml\n-GRAMAŽE SA ODNOSE NA TERMIČKI OBRAĐENE NAMIRNICE\nALKOHOL, GAZIRANO, SLATKO I SVE ŠTO NIJE IZBALANSIRANO U PROGRAMU JE ZABRANJENO\n-VODA 2L POPITI SVAKOG DANA\n-SO DO 3g DNEVNO, ZAČINSKO BILJE JE DOZVOLJENO (majčina dušica, bosljak, lovorov list )\n-HOD SREDNJEG INENZITETA SVAKOG DANA MINIMALNO POLA SATA UPRAŽNJAVATI\n-KAFA I ČAJ DO DVE ŠOLJE DNEVNO DOZVOLJENO, BEZ MLEKA I ŠEĆERA NAKON OBEDA\n-MLEKO I MLEČ.PROIZVODE DEGUSTIRATI SA MANJIM %m.m. ( 1%m.m., mlad sir do 10%m.m. )\n\n-OSAM NEDELJA TRAJE PROGRAM, NAKON TOGA KONTROLA\n\n"];
    

    [masterVC.ishranaDB setDatumUnosa:currentDate];
    [masterVC.ishranaDB setUserID:userMail];

    
    [masterVC addIshranaSaveDone];
    
    // set all defaults =  NO
    for (Ishrana *ish in  [coreDataManager getAllIshrane]) {
        [ish setIzabranaIshrana:NO];
    }
    
    // set current mere for Default YES
    Ishrana *ish = [coreDataManager getIshranaForName:masterVC.ishranaDB.ime];
    [ish setIzabranaIshrana:YES];
    
    [appDelegate saveContext];
    
    [self goToBack];

}


-(void)goToBack{

    [self.navigationController popToRootViewControllerAnimated:YES];
}


//-(void)keyboardWillShow {
//    // Animate the current view out of the way
//    if (self.view.frame.origin.y >= 0)
//    {
//        [self setViewMovedUp:YES];
//    }
//    else if (self.view.frame.origin.y < 0)
//    {
//        [self setViewMovedUp:NO];
//    }
//}
//
//-(void)keyboardWillHide {
//    if (self.view.frame.origin.y >= 0)
//    {
//        [self setViewMovedUp:YES];
//    }
//    else if (self.view.frame.origin.y < 0)
//    {
//        [self setViewMovedUp:NO];
//    }
//}
//
//-(void)textFieldDidBeginEditing:(UITextView *)sender
//{
//    //if ([sender isEqual:mailTf])
//    //{
//        //move the main view, so that the keyboard does not hide it.
//        if  (self.view.frame.origin.y >= 0)
//        {
//            [self setViewMovedUp:YES];
//        }
//   // }
//}
//
////method to move the view up/down whenever the keyboard is shown/dismissed
//-(void)setViewMovedUp:(BOOL)movedUp
//{
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
//
//    CGRect rect = self.view.frame;
//    if (movedUp)
//    {
//        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
//        // 2. increase the size of the view so that the area behind the keyboard is covered up.
//        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
//        rect.size.height += kOFFSET_FOR_KEYBOARD;
//    }
//    else
//    {
//        // revert back to the normal state.
//        rect.origin.y += kOFFSET_FOR_KEYBOARD;
//        rect.size.height -= kOFFSET_FOR_KEYBOARD;
//    }
//    self.view.frame = rect;
//
//    [UIView commitAnimations];
//}





/////////////////////////
- (void)keyboardWasShown:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];

    UIEdgeInsets contentInset = self.scrollView.contentInset;
    contentInset.bottom = keyboardRect.size.height;
    self.scrollView.contentInset = contentInset;
}

- (void)keyboardWillBeHidden:(NSNotification*)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
}

#pragma mark TextField Delegates
- (BOOL)textViewShouldReturn:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}

/////////////////////////

//- (void)keyboardWasShown:(NSNotification *)notification
//{
//    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//
//    [UIView animateWithDuration:0.3 animations:^{
//        CGRect f = self.view.frame;
//        f.origin.y = -keyboardSize.height+50;
//        self.scrollView.frame = f;
//    }];
//}
//
//-(void)keyboardWillBeHidden:(NSNotification *)notification
//{
//    [UIView animateWithDuration:0.3 animations:^{
//        CGRect f = self.view.frame;
//        f.origin.y = 0.0f;
//        self.scrollView.frame = f;
//    }];
//}

//- (void)keyboardWasShown:(NSNotification *)aNotification {
//    NSDictionary *info = [aNotification userInfo];
//    CGSize kbSize =  [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
//    self.scrollView.contentInset = contentInsets;
//    self.scrollView.scrollIndicatorInsets = contentInsets;
//
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.7]; // if you want to slide up the view
//
//    CGRect frame = CGRectMake( 0, CGRectGetMaxY(progressViewTop.frame), self.view.frame.size.width, self.view.frame.size.height-((self.navigationController.navigationBar.frame.size.height+ (self.tabBarController.tabBar.frame.size.height)+[[UIApplication sharedApplication] statusBarFrame].size.height)));
//    self.scrollView.frame= frame;
//
//    //[self.view setFrame:CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y-kbSize.height/1.2), self.view.frame.size.width, self.view.frame.size.height)];
//    [UIView commitAnimations];
//
//}
//
//// Called when the UIKeyboardWillHideNotification is sent
//- (void)keyboardWillBeHidden:(NSNotification *)aNotification {
//    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
//    self.scrollView.contentInset = contentInsets;
//    self.scrollView.scrollIndicatorInsets = contentInsets;
//    CGRect frame = CGRectMake( 0, CGRectGetMaxY(progressViewTop.frame), self.view.frame.size.width, self.view.frame.size.height-((self.navigationController.navigationBar.frame.size.height+ (self.tabBarController.tabBar.frame.size.height)+[[UIApplication sharedApplication] statusBarFrame].size.height)));
//    self.scrollView= [[UIScrollView alloc] initWithFrame:frame];
//
//    [self.scrollView setFrame:CGRectMake( 0, 0, self.view.frame.size.width, self.view.frame.size.height-1)];
//}



@end
