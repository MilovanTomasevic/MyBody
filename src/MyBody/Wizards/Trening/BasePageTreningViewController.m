//
//  BasePageViewController.m
//  MyBody
//
//  Created by Milovan Tomasevic on 03/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "BasePageTreningViewController.h"

@interface BasePageTreningViewController ()

@end

@implementation BasePageTreningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadPageControl];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [progressViewTop startAnimating];
    [progressViewDown startAnimating];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [progressViewTop stopAnimating];
    [progressViewDown stopAnimating];
}


-(void) loadPageControl{
    
//    int pagesCount = 7;
//
//    _pControl = [[UIPageControl alloc]init];
//    [_pControl setPageIndicatorTintColor:[UIColor whiteColor]];
//    [_pControl setCurrentPageIndicatorTintColor:[UIColor orangeColor]];
//    //[_pControl setBackgroundColor:[UIColor clearColor]];
//    [_pControl setNumberOfPages:pagesCount];
//    [_pControl setCurrentPage:0];
//
//    //  bottom position
//    //[_pControl setFrame:CGRectMake(0, self.view.frame.size.height - 55, self.view.frame.size.width, 55)];
//
//    // top position
//    [_pControl setFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame)+2, self.view.frame.size.width, 55)];
//    [_pControl setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
//    [self.view addSubview:_pControl];
    
    NSArray *itemArray = [NSArray arrayWithObjects: NSLocalizedString(@"Pon", nil), NSLocalizedString(@"Uto", nil), NSLocalizedString(@"Sre", nil), NSLocalizedString(@"Čet", nil), NSLocalizedString(@"Pet", nil), NSLocalizedString(@"Sub", nil), NSLocalizedString(@"Ned", nil), nil];
    
    self.pControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    self.pControl.frame =CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.frame.size.width, 50);
    self.pControl.backgroundColor = [UIColor whiteColor];
    self.pControl.tintColor = [UIColor orangeColor];
    self.pControl.selectedSegmentIndex = 0;
    //segmentedControl.layer.cornerRadius = 15.0;
    self.pControl.layer.borderColor = [UIColor whiteColor].CGColor;
    self.pControl.layer.borderWidth = 1.0f;
    self.pControl.layer.masksToBounds = YES;
    self.pControl.userInteractionEnabled=NO;
    [self.pControl addTarget:self
                         action:@selector(segmentSwitch)
               forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.pControl];
    
    
    self.freeDay = [[MTFansyTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pControl.frame), self.view.frame.size.width/2, 50)];
    [self.freeDay customizeFansyField:self.freeDay withView:self.view andPlaceholder:@"Slobodan dan (DA/NE)" border:YES radius:NO changeColoc:NO];
    self.freeDay.userInteractionEnabled = NO;
    self.freeDay.text = @"";
    
    self.emptyField = [[MTFansyTextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.freeDay.frame), CGRectGetMaxY(self.pControl.frame), self.view.frame.size.width/2, 50)];
    [self.emptyField customizeFansyField:self.emptyField withView:self.view andPlaceholder:@"" border:YES radius:NO changeColoc:NO];
    self.emptyField.userInteractionEnabled = NO;
    
    self.fokusTreningIme = [[MTFansyTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.freeDay.frame), self.view.frame.size.width, 50)];
    [self.fokusTreningIme customizeFansyField:self.fokusTreningIme withView:self.view andPlaceholder:@"Ime treninga (fokus na grupu misica)" border:YES radius:NO changeColoc:NO];
    
    _switchSegmentedControl = [[NYSegmentedControl alloc] initWithItems:@[@"DA", @"NE"]];
    //_switchSegmentedControl.frame =CGRectMake(CGRectGetMaxX(self.freeDay.frame)+3.5, CGRectGetMaxY(self.pControl.frame)+5, CGRectGetMaxX(self.emptyField.frame)-8, 40);
    _switchSegmentedControl.frame = CGRectMake(0, 0, self.emptyField.frame.size.width-3, 40);
    [_switchSegmentedControl setCenter:self.emptyField.center];
    [_switchSegmentedControl addTarget:self action:@selector(segmentSwitchYesNo) forControlEvents:UIControlEventValueChanged];
    _switchSegmentedControl.borderWidth = 0.7f;
    _switchSegmentedControl.borderColor = [UIColor blackColor];
    _switchSegmentedControl.titleFont = [UIFont fontWithName:@"AvenirNext-Medium" size:12.0f];
    _switchSegmentedControl.titleTextColor = [UIColor blackColor];
    _switchSegmentedControl.selectedTitleFont = [UIFont fontWithName:@"AvenirNext-DemiBold" size:12.0f];
    _switchSegmentedControl.selectedTitleTextColor = [UIColor whiteColor];
    _switchSegmentedControl.drawsGradientBackground = YES;
    _switchSegmentedControl.gradientTopColor = [UIColor redColor];
    _switchSegmentedControl.gradientBottomColor = [UIColor yellowColor];
    _switchSegmentedControl.segmentIndicatorAnimationDuration = 0.2f;
    _switchSegmentedControl.segmentIndicatorInset = 6.0f;
    _switchSegmentedControl.drawsSegmentIndicatorGradientBackground = YES;
    _switchSegmentedControl.segmentIndicatorGradientTopColor = [UIColor grayColor];
    _switchSegmentedControl.segmentIndicatorGradientBottomColor = [UIColor blueColor];
    _switchSegmentedControl.segmentIndicatorBorderWidth = 0.0f;
    _switchSegmentedControl.cornerRadius = 20.0f;
    _switchSegmentedControl.translatesAutoresizingMaskIntoConstraints = NO;
    //[_switchSegmentedControl.widthAnchor constraintEqualToConstant:140.0f].active = YES;
    //[_switchSegmentedControl.heightAnchor constraintEqualToConstant:70.0f].active = YES;
    _switchSegmentedControl.selectedSegmentIndex = 1;
    [self.view addSubview:_switchSegmentedControl];
    
    
    CGRect frameTop = CGRectMake(0, CGRectGetMaxY(self.fokusTreningIme.frame), self.view.frame.size.width, 3.0f);
    
    
    self.tvTrening = [MTFansyTextView new];
    [self.tvTrening customizeFansyTextView:self.tvTrening withView:self.view andPlaceholder:@""];
    self.tvTrening.frame = CGRectMake(0, CGRectGetMaxY(frameTop) , self.view.frame.size.width, 300);
    self.tvTrening.text = @" ";
    
    [MTSupport setDoneOnKeyboard:self.tvTrening withDoneSelector:@selector(doneClicked:) withObject:self];
    

    CGRect frameDown = CGRectMake(0, CGRectGetMaxY(self.tvTrening.frame), self.view.frame.size.width, 3.0f);
    progressViewTop = [[MTGradientProgressView alloc] initWithFrame:frameTop];
    progressViewDown = [[MTGradientProgressView alloc] initWithFrame:frameDown];
    [self.view addSubview:progressViewTop];
    [self.view addSubview:progressViewDown];
    [progressViewTop setProgress:1];
    [progressViewDown setProgress:1];
    [progressViewTop startAnimating];
    [progressViewDown startAnimating];
    
    UISwipeGestureRecognizer * swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
    swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeleft];
    
    UISwipeGestureRecognizer * swiperight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
    swiperight.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swiperight];
}

-(void)segmentSwitchYesNo{
    
    [self.view endEditing:YES];
    
    if(_switchSegmentedControl.selectedSegmentIndex==0 ){
        self.freeDay.text = @"DA";
        self.tvTrening.userInteractionEnabled=NO;
        self.tvTrening.backgroundColor = [self.tvTrening.backgroundColor colorWithAlphaComponent:0.3];
        [self segmentSwitch];
        self.tvTrening.text = @"Pauza. Danas se uziva :)";
        self.fokusTreningIme.backgroundColor = [self.tvTrening.backgroundColor colorWithAlphaComponent:0.3];
        self.fokusTreningIme.text = @"Odmaranje, treninga bez. 💪🏻🤞🏻";
        self.fokusTreningIme.userInteractionEnabled = NO;
    }else{
        self.freeDay.text = @"NE";
        self.tvTrening.userInteractionEnabled=YES;
        self.tvTrening.backgroundColor = [UIColor whiteColor];
        [self segmentSwitch];
        [self.tvTrening setSelectedRange:NSMakeRange(0, self.tvTrening.text.length)];
        [self.tvTrening setText:@" "];
        self.fokusTreningIme.backgroundColor = [UIColor whiteColor];
        self.fokusTreningIme.text = @"";
        self.fokusTreningIme.userInteractionEnabled = YES;
    }
}

-(void)segmentSwitch{
    
    [self.view endEditing:YES];
    
    switch (self.pControl.selectedSegmentIndex) {
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

-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    //[self nextPage];
}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    //[self customBackButtonPressed];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if(![touch.view isKindOfClass:[UITextView class]]) {
        [touch.view endEditing:YES];
    }
}

- (IBAction)doneClicked:(id)sender
{
    [self.view endEditing:YES];
}

@end
