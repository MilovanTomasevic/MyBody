//
//  NewTreningViewController.m
//  MyBody
//
//  Created by Milovan Tomasevic on 03/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "NewTreningViewController.h"
#import "NYSegmentedControl.h"

@interface NewTreningViewController ()

@end

@implementation NewTreningViewController{
    UISegmentedControl *segmentedControl;
    NYSegmentedControl *switchSegmentedControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadPage];
    
}



-(void)loadPage{
    
     [[UINavigationBar appearance] setTintColor:[THEME_MANAGER getAccentColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [THEME_MANAGER getAccentColor]}];
    
    UIBarButtonItem* doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onTapDone:)];
    doneBtn.title=@"Dodaj";
    
    
    UIButton* btnHelp = [MTButton createNavBarButton:NSLocalizedString(@"Help", nil)];
    [btnHelp addTarget:self action:@selector(showHelpText) forControlEvents:UIControlEventTouchUpInside];
    self.helpTrening = [[UIBarButtonItem alloc] initWithCustomView:btnHelp];
    self.navigationItem.rightBarButtonItems = @[doneBtn,self.helpTrening];
    
    
    NSArray *itemArray = [NSArray arrayWithObjects: NSLocalizedString(@"Pon", nil), NSLocalizedString(@"Uto", nil), NSLocalizedString(@"Sre", nil), NSLocalizedString(@"Čet", nil), NSLocalizedString(@"Pet", nil), NSLocalizedString(@"Sub", nil), NSLocalizedString(@"Ned", nil), nil];
    
//    segmentedControl = [[NYSegmentedControl alloc] initWithItems:itemArray];
//
//    // Add desired targets/actions
//    [segmentedControl addTarget:self action:@selector(segmentSwitch:) forControlEvents:UIControlEventValueChanged];
//
//    // Customize and size the control
//    segmentedControl.titleTextColor = [THEME_MANAGER getBackgroundColor];
//    segmentedControl.selectedTitleTextColor = [THEME_MANAGER getTextColor];
//    segmentedControl.segmentIndicatorBackgroundColor = [THEME_MANAGER getAccentColor];
//    segmentedControl.backgroundColor = [UIColor grayColor];
//    segmentedControl.borderWidth = 0.0f;
//    segmentedControl.segmentIndicatorBorderWidth = 0.0f;
//    segmentedControl.segmentIndicatorInset = 2.0f;
//    segmentedControl.segmentIndicatorBorderColor = self.view.backgroundColor;
//    segmentedControl.cornerRadius = segmentedControl.intrinsicContentSize.height / 2.0f;
//    segmentedControl.usesSpringAnimations = YES;
//    segmentedControl.frame =CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame)+3, self.view.frame.size.width, 50);
//    segmentedControl.selectedSegmentIndex = 0;
//    // Add the control to your view
//    //self.navigationItem.titleView = self->segmentedControl;
//    [self.view addSubview:segmentedControl];
    
    segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    segmentedControl.frame =CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.frame.size.width, 50);
    segmentedControl.backgroundColor = [UIColor whiteColor];
    segmentedControl.tintColor = [UIColor orangeColor];
    segmentedControl.selectedSegmentIndex = 0;
    //segmentedControl.layer.cornerRadius = 15.0;
    segmentedControl.layer.borderColor = [UIColor whiteColor].CGColor;
    segmentedControl.layer.borderWidth = 1.0f;
    segmentedControl.layer.masksToBounds = YES;
    [segmentedControl addTarget:self
                         action:@selector(segmentSwitch:)
               forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    
    NSDateFormatter *today=[[NSDateFormatter alloc] init];
    [today setDateFormat:@"dd.MM.yyyy. HH:mm:ss"];
    NSString *dateString = [today stringFromDate:[NSDate date]];
    
    self.imeTreninga = [[MTFansyTextField alloc]init];
    [self.imeTreninga customizeFansyField:self.imeTreninga withView:self.view andPlaceholder:@"Ime treninga" border:YES radius:NO changeColoc:NO];
    self.imeTreninga.frame =CGRectMake(0, CGRectGetMaxY(segmentedControl.frame), 2*self.view.frame.size.width/3 - 5, 50);
    
    self.datum = [[MTFansyTextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imeTreninga.frame), CGRectGetMaxY(segmentedControl.frame), self.view.frame.size.width, 50)];
    [self.datum customizeFansyField:self.datum withView:self.view andPlaceholder:@"Datum i vreme" border:YES radius:NO changeColoc:NO];
    self.datum.text = dateString;
    [self.datum setFont:[UIFont systemFontOfSize:11]];
    self.datum.userInteractionEnabled = NO;
    
    self.freeDay = [[MTFansyTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imeTreninga.frame), self.view.frame.size.width/2, 50)];
    [self.freeDay customizeFansyField:self.freeDay withView:self.view andPlaceholder:@"Slobodan dan (DA/NE)" border:YES radius:NO changeColoc:NO];
    self.freeDay.userInteractionEnabled = NO;
    self.freeDay.text = @"";
    
    self.emptyField = [[MTFansyTextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.freeDay.frame), CGRectGetMaxY(self.imeTreninga.frame), self.view.frame.size.width/2, 50)];
    [self.emptyField customizeFansyField:self.emptyField withView:self.view andPlaceholder:@"" border:YES radius:NO changeColoc:NO];
    self.emptyField.userInteractionEnabled = NO;
    
    switchSegmentedControl = [[NYSegmentedControl alloc] initWithItems:@[@"DA", @"NE"]];
    switchSegmentedControl.frame =CGRectMake(CGRectGetMaxX(self.freeDay.frame)+3.5, CGRectGetMaxY(self.imeTreninga.frame)+5, CGRectGetMaxX(self.freeDay.frame)-8, 40);
    [switchSegmentedControl addTarget:self action:@selector(segmentSwitchYesNo:) forControlEvents:UIControlEventValueChanged];
    switchSegmentedControl.borderWidth = 0.7f;
    switchSegmentedControl.borderColor = [UIColor blackColor];
    switchSegmentedControl.titleFont = [UIFont fontWithName:@"AvenirNext-Medium" size:12.0f];
    switchSegmentedControl.titleTextColor = [UIColor blackColor];
    switchSegmentedControl.selectedTitleFont = [UIFont fontWithName:@"AvenirNext-DemiBold" size:12.0f];
    switchSegmentedControl.selectedTitleTextColor = [UIColor whiteColor];
    switchSegmentedControl.drawsGradientBackground = YES;
    switchSegmentedControl.gradientTopColor = [UIColor redColor];
    switchSegmentedControl.gradientBottomColor = [UIColor yellowColor];
    switchSegmentedControl.segmentIndicatorAnimationDuration = 0.2f;
    switchSegmentedControl.segmentIndicatorInset = 6.0f;
    switchSegmentedControl.drawsSegmentIndicatorGradientBackground = YES;
    switchSegmentedControl.segmentIndicatorGradientTopColor = [UIColor grayColor];
    switchSegmentedControl.segmentIndicatorGradientBottomColor = [UIColor blueColor];
    switchSegmentedControl.segmentIndicatorBorderWidth = 0.0f;
    switchSegmentedControl.cornerRadius = 20.0f;
    //switchSegmentedControl.translatesAutoresizingMaskIntoConstraints = NO;
    [switchSegmentedControl.widthAnchor constraintEqualToConstant:140.0f].active = YES;
    [switchSegmentedControl.heightAnchor constraintEqualToConstant:70.0f].active = YES;
    switchSegmentedControl.selectedSegmentIndex = 1;
    [self.view addSubview:switchSegmentedControl];
    
    CGRect frameTop = CGRectMake(0, CGRectGetMaxY(self.freeDay.frame), self.view.frame.size.width, 3.0f);
    
    
    self.tvTrening = [MTFansyTextView new];
    [self.tvTrening setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.tvTrening.frame = CGRectMake(0, CGRectGetMaxY(self.freeDay.frame) , self.view.frame.size.width, 300);
    self.tvTrening.placeholder = @"";
    self.tvTrening.floatLabelActiveColor = [THEME_MANAGER getAccentColor];
    self.tvTrening.floatLabelPassiveColor = [UIColor lightGrayColor];
    self.tvTrening.layer.borderColor = [[THEME_MANAGER getAccentColor] CGColor];
    self.tvTrening.font = [UIFont systemFontOfSize:19.0f];
    self.tvTrening.floatLabel.font = [UIFont systemFontOfSize:12.0f];
    self.tvTrening.backgroundColor = [THEME_MANAGER getTextColor];
    self.tvTrening.delegate = self;
    [self.view addSubview:self.tvTrening];

    CGRect frameDown = CGRectMake(0, CGRectGetMaxY(self.tvTrening.frame), self.view.frame.size.width, 3.0f);
    progressViewTop = [[MTGradientProgressView alloc] initWithFrame:frameTop];
    progressViewDown = [[MTGradientProgressView alloc] initWithFrame:frameDown];
    [self.view addSubview:progressViewTop];
    [self.view addSubview:progressViewDown];
    [progressViewTop setProgress:1];
    [progressViewDown setProgress:1];
    [progressViewTop startAnimating];
    [progressViewDown startAnimating];
    
}

- (IBAction)segmentSwitch:(UISegmentedControl *)sender {
    
    [self.view endEditing:YES];
    
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            self.navigationItem.title = @"Ponedeljak";
            self.tvTrening.placeholder = @"Trening za ponedeljak:";
            break;
        case 1:
            self.navigationItem.title = @"Utorak";
            self.tvTrening.placeholder = @"Trening za utorak:";
            break;
        case 2:
            self.navigationItem.title = @"Sreda";
            self.tvTrening.placeholder = @"Trening za sredu:";
            break;
        case 3:
            self.navigationItem.title = @"Četvrtak";
            self.tvTrening.placeholder = @"Trening za četvrtak:";
            break;
        case 4:
            self.navigationItem.title = @"Petak";
            self.tvTrening.placeholder = @"Trening za petak:";
            break;
        case 5:
            self.navigationItem.title = @"Subota";
            self.tvTrening.placeholder = @"Trening za subotu:";
            break;
        case 6:
            self.navigationItem.title = @"Nedelja";
            self.tvTrening.placeholder = @"Trening za nedelju:";
            break;

        default: break;
    }
}


-(void)onTapDone:(UIBarButtonItem*)item{
    
    [self.view endEditing:YES];
    [MTSupport progressDone:@"Trening unet." andView:self.navigationController.view];
    [progressViewTop stopAnimating];
    [progressViewDown stopAnimating];
    
}

-(void)showHelpText{
    
    NSString* messageString =  @"Ako ne trenirate svaki dan onda izaberete opciju slobodan trening.";
    
    [ALERT_PRESENTER presentAlertControllerWithConfigurationHandler:^(MTAlertDescriptor * descriptor) {
        descriptor.priority = MTAlertPriorityNormal;
        descriptor.title = NSLocalizedString(@"Slobodan dan", nil);
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if(![touch.view isMemberOfClass:[UITextView class]]) {
        [touch.view endEditing:YES];
    }
//    if([touch.view isKindOfClass:(NYSegmentedControl.class)]){
//        switch (segmentedControl.selectedSegmentIndex) {
//            case 0:
//                self.navigationItem.title = @"Ponedeljak";
//                self.tvTrening.placeholder = @"Trening za ponedeljak:";
//                break;
//            case 1:
//                self.navigationItem.title = @"Utorak";
//                self.tvTrening.placeholder = @"Trening za utorak:";
//                break;
//            case 2:
//                self.navigationItem.title = @"Sreda";
//                self.tvTrening.placeholder = @"Trening za sredu:";
//                break;
//            case 3:
//                self.navigationItem.title = @"Četvrtak";
//                self.tvTrening.placeholder = @"Trening za četvrtak:";
//                break;
//            case 4:
//                self.navigationItem.title = @"Petak";
//                self.tvTrening.placeholder = @"Trening za petak:";
//                break;
//            case 5:
//                self.navigationItem.title = @"Subota";
//                self.tvTrening.placeholder = @"Trening za subotu:";
//                break;
//            case 6:
//                self.navigationItem.title = @"Nedelja";
//                self.tvTrening.placeholder = @"Trening za nedelju:";
//                break;
//
//            default: break;
//        }
//    }
}

- (IBAction)segmentSwitchYesNo:(NYSegmentedControl *)sender {
    
    [self.view endEditing:YES];
    
    if(switchSegmentedControl.selectedSegmentIndex==0 ){
        self.freeDay.text = @"DA";
        self.tvTrening.userInteractionEnabled=NO;
        self.tvTrening.backgroundColor = [UIColor lightGrayColor];
        self.tvTrening.text = @"Pauza. Danas se uziva :)";
    }else{
        self.freeDay.text = @"NE";
        self.tvTrening.userInteractionEnabled=YES;
        self.tvTrening.backgroundColor = [UIColor whiteColor];
        [self.tvTrening setSelectedRange:NSMakeRange(0, self.tvTrening.text.length)];
        [self.tvTrening setText:@""];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


@end
