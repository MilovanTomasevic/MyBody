//
//  NewMereViewController.m
//  MyBody
//
//  Created by Milovan Tomasevic on 01/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "NewMereViewController.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

@interface NewMereViewController (){
    AppDelegate *appDelegate;
}

@end

@implementation NewMereViewController{
    MBProgressHUD *HUD;
    MTFansyTextField *prenizak, *idealan, *laganoVisok, *visok, *previsok, *izrazitoVisok;
    UIImageView *imageHolder;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.coreDataManager = [[CoreDataManager alloc]init];
    self.mereDB = [self.coreDataManager getNewMere];

    [self loadPage];
}




-(void)onTapDone:(UIBarButtonItem*)item{

    [self checkEntryData];
    
}

- (IBAction)segmentSwitch:(NYSegmentedControl *)sender {
    
    [self.view endEditing:YES];
    
    if(self.switchSegmentedControl.selectedSegmentIndex==0 ){
        self.pol.text = @"M";
    }else{
        self.pol.text = @"Ž";
    }
}

-(void)showTextForBMI{
    
    NSString* messageString =  @"Indeks telesne mase (engl. Body Mass Index, BMI) je metoda računanja uhranjenosti. BMI se izračunava vrlo jednostavno, a temelji se na odnosu telesne težine i visine osobe. Što je indeks više izvan okvira urednih vrednosti, to je veći rizik od obolevanja od raznih srčanih bolesti, dijabetesa i povišenog krvnog pritiska.\n\nBMI treba shvatiti kao okvirnu metodu, budući da stvarno zdravstveno stanje osobe treba oceniti u širem medicinskom kontekstu.\n";
    
    [ALERT_PRESENTER presentAlertControllerWithConfigurationHandler:^(MTAlertDescriptor * descriptor) {
        descriptor.priority = MTAlertPriorityNormal;
        descriptor.title = NSLocalizedString(@"BMI", nil);
        descriptor.message = messageString;
        descriptor.cancelTitle = NSLocalizedString(@"OK", nil);
        //descriptor.otherTitles = @[NSLocalizedString(@"retry", nil)];
        [descriptor setTapBlock:^(UIAlertController *controller, UIAlertAction *action, NSInteger buttonIndex) {
            if (buttonIndex == MTAlertBlocksCancelButtonIndex) {

            }else{
            }
        }];
    }];
}


- (IBAction)doneClicked:(id)sender
{
    [self.view endEditing:YES];
}

-(void)loadPage{
    
    NSDateFormatter *today=[[NSDateFormatter alloc] init];
    [today setDateFormat:@"dd.MM.yyyy. HH:mm:ss"];
    NSString *dateString = [today stringFromDate:[NSDate date]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [THEME_MANAGER getAccentColor]}];
    
    UIBarButtonItem* doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onTapDone:)];
    doneBtn.title=@"Dodaj";
    
    
    UIButton* btnBMI = [MTButton createNavBarButton:NSLocalizedString(@"BMI", nil)];
    [btnBMI addTarget:self action:@selector(showTextForBMI) forControlEvents:UIControlEventTouchUpInside];
    _helpBMI = [[UIBarButtonItem alloc] initWithCustomView:btnBMI];
    self.navigationItem.rightBarButtonItems = @[doneBtn,_helpBMI];
    
    self.imeMerenja = [[MTFansyTextField alloc]init];
    [self.imeMerenja customizeFansyField:self.imeMerenja withView:self.view andPlaceholder:@"Ime merenja" border:NO radius:NO changeColoc:NO];
    self.imeMerenja.frame =CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), 2*self.view.frame.size.width/3 - 5, 50);
    
    self.datum = [[MTFansyTextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imeMerenja.frame), CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.frame.size.width, 50)];
    [self.datum customizeFansyField:self.datum withView:self.view andPlaceholder:@"Datum i vreme" border:NO radius:NO changeColoc:NO];
    
    self.datum.text = dateString;
    [self.datum setFont:[UIFont systemFontOfSize:11]];
    self.datum.userInteractionEnabled = NO;
    
    self.pol = [[MTFansyTextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.tezina.frame), CGRectGetMaxY(self.imeMerenja.frame), self.view.frame.size.width/5, 50)];
    [self.pol customizeFansyField:self.pol withView:self.view andPlaceholder:@"Pol(m/ž)" border:YES radius:NO changeColoc:NO];
    self.pol.userInteractionEnabled = NO;
    self.pol.text = @"Ž";
    
    self.emptyField = [[MTFansyTextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.pol.frame), CGRectGetMaxY(self.imeMerenja.frame), self.view.frame.size.width/5, 50)];
    
    [self.emptyField customizeFansyField:self.emptyField withView:self.view andPlaceholder:@"" border:YES radius:NO changeColoc:NO];
    self.emptyField.userInteractionEnabled = NO;
    
    self.godine = [[MTFansyTextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.emptyField.frame), CGRectGetMaxY(self.imeMerenja.frame), self.view.frame.size.width/5, 50)];
    [self.godine customizeFansyField:self.godine withView:self.view andPlaceholder:@"Godine" border:YES radius:NO changeColoc:NO];
    [MTSupport setNumericKeyboardWithDone:self.godine withDoneSelector:@selector(doneClicked:) withObject:self];
    
    self.visina = [[MTFansyTextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.godine.frame), CGRectGetMaxY(self.imeMerenja.frame), self.view.frame.size.width/5, 50)];
    [self.visina customizeFansyField:self.visina withView:self.view andPlaceholder:@"Visina" border:YES radius:NO changeColoc:NO];
    [MTSupport setNumericKeyboardWithDone:self.visina withDoneSelector:@selector(doneClicked:) withObject:self];
    
    self.tezina = [[MTFansyTextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.visina.frame), CGRectGetMaxY(self.imeMerenja.frame), self.view.frame.size.width/5, 50)];
    [self.tezina customizeFansyField:self.tezina withView:self.view andPlaceholder:@"Tezina" border:YES radius:NO changeColoc:NO];
    [MTSupport setNumericKeyboardWithDecimal:self.tezina withDoneSelector:@selector(doneClicked:) withObject:self];
    
    self.obimKuka = [[MTFansyTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.visina.frame), self.view.frame.size.width/4, 50)];
    [self.obimKuka customizeFansyField:self.obimKuka withView:self.view andPlaceholder:@"Kuk(cm)" border:YES radius:NO changeColoc:NO];
    [MTSupport setNumericKeyboardWithDecimal:self.obimKuka withDoneSelector:@selector(doneClicked:) withObject:self];
    
    self.obimGrudi = [[MTFansyTextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.obimKuka.frame), CGRectGetMaxY(self.visina.frame), self.view.frame.size.width/4, 50)];
    [self.obimGrudi customizeFansyField:self.obimGrudi withView:self.view andPlaceholder:@"Grudi(cm)" border:YES radius:NO changeColoc:NO];
    [MTSupport setNumericKeyboardWithDecimal:self.obimGrudi withDoneSelector:@selector(doneClicked:) withObject:self];
    
    self.obimButina = [[MTFansyTextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.obimGrudi.frame), CGRectGetMaxY(self.visina.frame), self.view.frame.size.width/4, 50)];
    [self.obimButina customizeFansyField:self.obimButina withView:self.view andPlaceholder:@"Butine (cm)" border:YES radius:NO changeColoc:NO];
    [MTSupport setNumericKeyboardWithDecimal:self.obimButina withDoneSelector:@selector(doneClicked:) withObject:self];
    
    self.BMI = [[MTFansyTextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.obimButina.frame), CGRectGetMaxY(self.visina.frame), self.view.frame.size.width/4, 50)];
    [self.BMI customizeFansyField:self.BMI withView:self.view andPlaceholder:@"BMI" border:YES radius:NO changeColoc:NO];
    self.BMI.userInteractionEnabled=NO;
    
    self.kratkaNapomena = [[MTFansyTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.obimKuka.frame), self.view.frame.size.width, 50)];
    [self.kratkaNapomena customizeFansyField:self.kratkaNapomena withView:self.view andPlaceholder:@"Kratka napomena" border:YES radius:NO changeColoc:NO];
    
    
    
    self.switchSegmentedControl = [[NYSegmentedControl alloc] initWithItems:@[@"M", @"Ž"]];
    //switchSegmentedControl.frame =CGRectMake(CGRectGetMaxX(self.pol.frame)+3.5, CGRectGetMaxY(self.imeMerenja.frame)+5, CGRectGetMaxX(self.pol.frame)-8, 40);
    self.switchSegmentedControl.frame = CGRectMake(0, 0, self.emptyField.frame.size.width-3, 40);
    [self.switchSegmentedControl setCenter:self.emptyField.center];
    [self.switchSegmentedControl addTarget:self action:@selector(segmentSwitch:) forControlEvents:UIControlEventValueChanged];
    self.switchSegmentedControl.borderWidth = 0.7f;
    self.switchSegmentedControl.borderColor = [UIColor blackColor];
    self.switchSegmentedControl.titleFont = [UIFont fontWithName:@"AvenirNext-Medium" size:12.0f];
    self.switchSegmentedControl.titleTextColor = [UIColor blackColor];
    self.switchSegmentedControl.selectedTitleFont = [UIFont fontWithName:@"AvenirNext-DemiBold" size:12.0f];
    self.switchSegmentedControl.selectedTitleTextColor = [UIColor whiteColor];
    self.switchSegmentedControl.drawsGradientBackground = YES;
    self.switchSegmentedControl.gradientTopColor = [UIColor redColor];
    self.switchSegmentedControl.gradientBottomColor = [UIColor yellowColor];
    self.switchSegmentedControl.segmentIndicatorAnimationDuration = 0.2f;
    self.switchSegmentedControl.segmentIndicatorInset = 6.0f;
    self.switchSegmentedControl.drawsSegmentIndicatorGradientBackground = YES;
    self.switchSegmentedControl.segmentIndicatorGradientTopColor = [UIColor grayColor];
    self.switchSegmentedControl.segmentIndicatorGradientBottomColor = [UIColor blueColor];
    self.switchSegmentedControl.segmentIndicatorBorderWidth = 0.0f;
    self.switchSegmentedControl.cornerRadius = 20.0f;
    self.switchSegmentedControl.translatesAutoresizingMaskIntoConstraints = YES;
//    [switchSegmentedControl.widthAnchor constraintEqualToConstant:140.0f].active = YES;
//    [switchSegmentedControl.heightAnchor constraintEqualToConstant:70.0f].active = YES;
    self.switchSegmentedControl.selectedSegmentIndex = 1;
    [self.view addSubview:self.switchSegmentedControl];
    
    self.btnBMI = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.kratkaNapomena.frame), self.view.frame.size.width, 70)];

    [self.btnBMI setTitle: NSLocalizedString(@"Izracunaj BMI",nil) forState:UIControlStateNormal];
    [self.btnBMI addTarget:self action:@selector(calculateBMI:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnBMI setBackgroundColor: [ UIColor whiteColor]];
    [self.btnBMI setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [[self.btnBMI layer] setBorderWidth:2.0f];
    [self.btnBMI.layer setBorderColor:[[UIColor clearColor] CGColor]];

    [self.view addSubview:self.btnBMI];
    
    
    CGRect frameTop = CGRectMake(0, CGRectGetMaxY(self.kratkaNapomena.frame), self.view.frame.size.width, 3.0f);
    CGRect frameDown = CGRectMake(0, CGRectGetMaxY(self.btnBMI.frame), self.view.frame.size.width, 3.0f);
    progressViewTop = [[MTGradientProgressView alloc] initWithFrame:frameTop];
    progressViewDown = [[MTGradientProgressView alloc] initWithFrame:frameDown];
    [self.view addSubview:progressViewTop];
    [self.view addSubview:progressViewDown];
    [progressViewTop setProgress:1];
    [progressViewDown setProgress:1];
    [progressViewTop startAnimating];
    [progressViewDown startAnimating];
    //[self simulateProgress];
    
    
    UIView *fakeView = [[UIView alloc] init];
    
    prenizak = [[MTFansyTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(progressViewDown.frame), self.view.frame.size.width/3, 50)];
    [prenizak customizeFansyField:prenizak withView:fakeView andPlaceholder:@"Prenizak" border:NO radius:NO changeColoc:NO];
    prenizak.userInteractionEnabled = NO;
    
    idealan = [[MTFansyTextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(prenizak.frame), CGRectGetMaxY(progressViewDown.frame), self.view.frame.size.width/3, 50)];
    [idealan customizeFansyField:idealan withView:fakeView andPlaceholder:@"Idealan" border:NO radius:NO changeColoc:NO];
    idealan.userInteractionEnabled = NO;
    
    laganoVisok = [[MTFansyTextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(idealan.frame), CGRectGetMaxY(progressViewDown.frame), self.view.frame.size.width/3, 50)];
    [laganoVisok customizeFansyField:laganoVisok withView:fakeView andPlaceholder:@"Lagano visok" border:NO radius:NO changeColoc:NO];
    laganoVisok.userInteractionEnabled = NO;
    
    visok = [[MTFansyTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(prenizak.frame), self.view.frame.size.width/3, 50)];
    [visok customizeFansyField:visok withView:fakeView andPlaceholder:@"Visok" border:NO radius:NO changeColoc:NO];
    visok.userInteractionEnabled = NO;
    
    previsok = [[MTFansyTextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(visok.frame), CGRectGetMaxY(prenizak.frame), self.view.frame.size.width/3, 50)];
    [previsok customizeFansyField:previsok withView:fakeView andPlaceholder:@"Previsok" border:NO radius:NO changeColoc:NO];
    previsok.userInteractionEnabled = NO;
    
    izrazitoVisok = [[MTFansyTextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(previsok.frame), CGRectGetMaxY(prenizak.frame), self.view.frame.size.width/3, 50)];
    [izrazitoVisok customizeFansyField:izrazitoVisok withView:fakeView andPlaceholder:@"Izrazito visok" border:NO radius:NO changeColoc:NO];
    izrazitoVisok.userInteractionEnabled = NO;
    
    imageHolder = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(izrazitoVisok.frame), self.view.frame.size.width, self.view.frame.size.height - (self.navigationController.navigationBar.frame.size.height+(6*self.imeMerenja.frame.size.height)+ (self.btnBMI.frame.size.height)+[[UIApplication sharedApplication] statusBarFrame].size.height + 2*progressViewDown.frame.size.height))];
    UIImage *image = [UIImage imageNamed:@"itm"];
   
    imageHolder.image = image;
    [imageHolder setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [imageHolder setAutoresizingMask:UIViewAutoresizingFlexibleHeight];

}

- (IBAction)calculateBMI:(id)sender
{
    [self.view endEditing:YES];
    
    if ([self.visina.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"Error",nil) message:NSLocalizedString(@"Unesite visinu",nil)];
        return;
    }
    if ([self.tezina.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"Error",nil) message:NSLocalizedString(@"Unesite tezinu",nil)];
        return;
    }
    
    [self.view addSubview:prenizak];
    [self.view addSubview:idealan];
    [self.view addSubview:laganoVisok];
    [self.view addSubview:visok];
    [self.view addSubview:previsok];
    [self.view addSubview:izrazitoVisok];
    
    [self.view addSubview:imageHolder];

    NSString *tezina = self.tezina.text;
    NSString *visina = self.visina.text;
    
    float brTezina = [tezina floatValue];
    float brVisina = [visina floatValue];
    
    float rez= (brTezina /(brVisina*brVisina))*10000;
    
    if(self.switchSegmentedControl.selectedSegmentIndex==0 ){
        prenizak.text = @"<20.7";
        idealan.text = @"20.7 - 26.4";
        laganoVisok.text = @"26.5 - 27.8";
        visok.text = @"27.9 - 31.1";
        previsok.text = @"31.2 - 45";
        izrazitoVisok.text = @">45";
        
        if (HAS_DECIMALS(rez)) {
            self.BMI.text = STR_FROM_FLOAT_2DECIMAL (rez);
        }
        else {
            self.BMI.text = STR_FROM_FLOAT_0DECIMAL (rez);
        }
        if (rez<20.7) {
            prenizak.layer.borderColor=[[UIColor orangeColor]CGColor];
            prenizak.layer.borderWidth= 3.0f;
        }if (rez >= 20.7 && rez<=26.4){
            idealan.layer.borderColor=[[UIColor orangeColor]CGColor];
            idealan.layer.borderWidth= 3.0f;
        }if(rez >= 26.5 && rez <= 28.8){
            laganoVisok.layer.borderColor=[[UIColor orangeColor]CGColor];
            laganoVisok.layer.borderWidth= 3.0f;
        }if(rez >= 27.9 && rez <= 31.1){
            visok.layer.borderColor=[[UIColor orangeColor]CGColor];
            visok.layer.borderWidth= 3.0f;
        }if(rez >= 31.2 && rez <= 45){
            previsok.layer.borderColor=[[UIColor orangeColor]CGColor];
            previsok.layer.borderWidth= 3.0f;
        }if(rez>45){
            izrazitoVisok.layer.borderColor=[[UIColor orangeColor]CGColor];
            izrazitoVisok.layer.borderWidth= 3.0f;
        }
    }else{
        
        prenizak.text = @"<19.1";
        idealan.text = @"19.1 - 25.8";
        laganoVisok.text = @"25.9 - 27.3";
        visok.text = @"27.4 - 32.3";
        previsok.text = @"32.4 - 45";
        izrazitoVisok.text = @">45";
        if (HAS_DECIMALS(rez)) {
            self.BMI.text = STR_FROM_FLOAT_2DECIMAL (rez);
        } else {
            self.BMI.text = STR_FROM_FLOAT_0DECIMAL (rez);
        }
        if (rez<19.1) {
            prenizak.layer.borderColor=[[UIColor orangeColor]CGColor];
            prenizak.layer.borderWidth= 3.0f;
        }if (rez >= 19.1 && rez<=25.8){
            idealan.layer.borderColor=[[UIColor orangeColor]CGColor];
            idealan.layer.borderWidth= 3.0f;
        }if(rez >= 25.9 && rez <= 27.3){
            laganoVisok.layer.borderColor=[[UIColor orangeColor]CGColor];
            laganoVisok.layer.borderWidth= 3.0f;
        }if(rez >= 27.4 && rez <= 32.2){
            visok.layer.borderColor=[[UIColor orangeColor]CGColor];
            visok.layer.borderWidth= 3.0f;
        }if(rez >= 32.4 && rez <= 45){
            previsok.layer.borderColor=[[UIColor orangeColor]CGColor];
            previsok.layer.borderWidth= 3.0f;
        }if(rez>45){
            izrazitoVisok.layer.borderColor=[[UIColor orangeColor]CGColor];
            izrazitoVisok.layer.borderWidth= 3.0f;
        }
    }
    self.BMI.layer.borderWidth = 3.0f;
}

//- (void)simulateProgress {
//
//    CGFloat increment = (arc4random() % 3)  *0.005+ 0.0015;
//    //CGFloat increment = 0.025;
//    CGFloat progress  = [progressView progress] + increment;
//    [progressView setProgress:progress];
//
//    LogI(@"Vrednost  ---  progress:%f i inkrement %f", progress, increment);
//
//    if (progress < 0.65) {
//        [self performSelector:@selector(simulateProgress) withObject:self afterDelay:0.5 ];
//    }
//    if (progress >= 0.65 && progress < 1) {
//        [self performSelector:@selector(simulateProgress) withObject:self afterDelay:3.0 ];
//    }
//    if ( progress >= 1) {
//        LogI(@"Konfiguracija zavrsena.");
//    }
//}



-(void)checkEntryData{
    
    [self.view endEditing:YES];
    
    self.imeMerenja.text = [self.imeMerenja.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.kratkaNapomena.text = [self.kratkaNapomena.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([self.imeMerenja.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"Error",nil) message:NSLocalizedString(@"Unesite ime merenja",nil)];
        return;
    }
    if ([self.godine.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"Error",nil) message:NSLocalizedString(@"Unesite broj godina",nil)];
        return;
    }
    if ([self.visina.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"Error",nil) message:NSLocalizedString(@"Unesite visinu",nil)];
        return;
    }
    if ([self.tezina.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"Error",nil) message:NSLocalizedString(@"Unesite tezinu",nil)];
        return;
    }
    if ([self.obimKuka.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"Error",nil) message:NSLocalizedString(@"Unesite obim kuka",nil)];
        return;
    }
    if ([self.obimGrudi.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"Error",nil) message:NSLocalizedString(@"Unesite obim grudi",nil)];
        return;
    }
    if ([self.obimButina.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"Error",nil) message:NSLocalizedString(@"Unesite obim butina",nil)];
        return;
    }
    if ([self.kratkaNapomena.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"Error",nil) message:NSLocalizedString(@"Unesite kratku napomenu",nil)];
        return;
    }
    
    [progressViewTop stopAnimating];
    [progressViewDown stopAnimating];
    
    NSDateFormatter *today=[[NSDateFormatter alloc] init];
    [today setDateFormat:@"dd.MM.yyyy. HH:mm:ss"];
    NSString *currentDate = [today stringFromDate:[NSDate date]];
    
    [self.mereDB setIme:self.imeMerenja.text];
    [self.mereDB setDatumMerenja:currentDate];
    [self.mereDB setPol:self.pol.text];
    [self.mereDB setGodine:self.godine.text];
    [self.mereDB setVisina:self.visina.text];
    [self.mereDB setTezina:self.tezina.text];
    [self.mereDB setObimKuka:self.obimKuka.text];
    [self.mereDB setObimGrudi:self.obimGrudi.text];
    [self.mereDB setObimButina:self.obimButina.text];
    [self.mereDB setBmi:self.BMI.text];
    [self.mereDB setKratkaNapomena:self.kratkaNapomena.text];
    [self.mereDB setIzabranaMera:NO];
    [self.mereDB setUserID:[[NSUserDefaults standardUserDefaults] valueForKey:PREF_USER_EMAIL]];

    [self saveData];
    [MTSupport progressDone:@"Mera uneta." andView:self.navigationController.view];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)saveData{
    
    [self.coreDataManager addOrUpdateMerenjeName:self.mereDB.ime forUserEmail:self.mereDB.userID datumMerenja:self.mereDB.datumMerenja pol:self.mereDB.pol godine:self.mereDB.godine visina:self.mereDB.visina tezina:self.mereDB.tezina obimKuka:self.mereDB.obimKuka obimGrudi:self.mereDB.obimGrudi obimButina:self.mereDB.obimButina bmi:self.mereDB.bmi izabranaMera:self.mereDB.izabranaMera];
    
    [appDelegate saveContext];
    
    // set all defaults =  NO
    for (Mere *m in  [self.coreDataManager getAllMere]) {
        [m setIzabranaMera:NO];
    }
    
    // set current mere for Default YES
    Mere *m = [self.coreDataManager getMereForName:self.mereDB.ime];
    [m setIzabranaMera:YES];

     [appDelegate saveContext];
}


@end
