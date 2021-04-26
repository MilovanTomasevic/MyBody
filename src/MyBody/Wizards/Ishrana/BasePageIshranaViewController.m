//
//  BasePageIshranaViewController.m
//  MyBody
//
//  Created by Milovan Tomasevic on 05/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "BasePageIshranaViewController.h"

@interface BasePageIshranaViewController ()

@end

@implementation BasePageIshranaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadPageControl];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self registerForKeyboardNotifications];
    [progressViewTop startAnimating];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self deregisterForKeyboardNotifications];
    [progressViewTop stopAnimating];
}


-(void) loadPageControl{
    
    
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
    

    
    CGRect frameTop = CGRectMake(0, CGRectGetMaxY(self.pControl.frame), self.view.frame.size.width, 3.0f);
    progressViewTop = [[MTGradientProgressView alloc] initWithFrame:frameTop];
    [self.view addSubview:progressViewTop];
    [progressViewTop setProgress:1];
    [progressViewTop startAnimating];
    
    
    CGRect frame = CGRectMake( 0, CGRectGetMaxY(progressViewTop.frame), self.view.frame.size.width, self.view.frame.size.height-((self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height)));
    self.scrollView= [[UIScrollView alloc] initWithFrame:frame];
    [_scrollView setBackgroundColor: [UIColor whiteColor]];
    [_scrollView setUserInteractionEnabled:YES];
    [_scrollView setScrollEnabled:YES];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    _scrollView.bounces = NO;
    
    self.tvDorucak = [MTFansyTextView new];
    self.tvUzina = [MTFansyTextView new];
    self.tvRucak = [MTFansyTextView new];
    self.tvUzina2 = [MTFansyTextView new];
    self.tvVecera = [MTFansyTextView new];
    
    [self.tvDorucak customizeFansyTextView:self.tvDorucak withView:self.scrollView andPlaceholder:@""];
    [self.tvUzina customizeFansyTextView:self.tvUzina withView:self.scrollView andPlaceholder:@""];
    [self.tvRucak customizeFansyTextView:self.tvRucak withView:self.scrollView andPlaceholder:@""];
    [self.tvUzina2 customizeFansyTextView:self.tvUzina2 withView:self.scrollView andPlaceholder:@""];
    [self.tvVecera customizeFansyTextView:self.tvVecera withView:self.scrollView andPlaceholder:@""];
    
    self.vremeDFiled = [MTFansyTextField new];
    self.vremeUFiled = [MTFansyTextField new];
    self.vremeRFiled = [MTFansyTextField new];
    self.vremeU2Filed = [MTFansyTextField new];
    self.vremeVFiled = [MTFansyTextField new];
    

    [self.vremeDFiled customizeFansyField:self.vremeDFiled withView:self.scrollView andPlaceholder:@"Vreme dorucka (h)" border:NO radius:NO changeColoc:NO];
    [self.vremeUFiled customizeFansyField:self.vremeUFiled withView:self.scrollView andPlaceholder:@"Vreme uzine (h)" border:NO radius:NO changeColoc:NO];
    [self.vremeRFiled customizeFansyField:self.vremeRFiled withView:self.scrollView andPlaceholder:@"Vreme rucka (h)" border:NO radius:NO changeColoc:NO];
    [self.vremeU2Filed customizeFansyField:self.vremeU2Filed withView:self.scrollView andPlaceholder:@"Vreme druge uzine (h)" border:NO radius:NO changeColoc:NO];
    [self.vremeVFiled customizeFansyField:self.vremeVFiled withView:self.scrollView andPlaceholder:@"Vreme vecere (h)" border:NO radius:NO changeColoc:NO];
    
    
    
    CGFloat sirinaPolja = self.view.frame.size.width * 0.4;

    self.vremeDFiled.frame = CGRectMake(self.view.frame.size.width/2 - sirinaPolja/2, 0, sirinaPolja, 45);
    self.tvDorucak.frame = CGRectMake(0, CGRectGetMaxY(self.vremeDFiled.frame), self.view.frame.size.width, 200);
    
    self.vremeUFiled.frame = CGRectMake(self.view.frame.size.width/2 - sirinaPolja/2, CGRectGetMaxY(self.tvDorucak.frame),sirinaPolja, 45);
    self.tvUzina.frame = CGRectMake(0, CGRectGetMaxY(self.vremeUFiled.frame) , self.scrollView.frame.size.width, 200);
    
    self.vremeRFiled.frame = CGRectMake(self.view.frame.size.width/2 - sirinaPolja/2, CGRectGetMaxY(self.tvUzina.frame), sirinaPolja, 45);
    self.tvRucak.frame = CGRectMake(0, CGRectGetMaxY(self.vremeRFiled.frame) , self.scrollView.frame.size.width, 200);
    
    self.vremeU2Filed.frame = CGRectMake(self.view.frame.size.width/2 - sirinaPolja/2, CGRectGetMaxY(self.tvRucak.frame), sirinaPolja, 45);
    self.tvUzina2.frame = CGRectMake(0, CGRectGetMaxY(self.vremeU2Filed.frame) , self.scrollView.frame.size.width, 200);
    
    self.vremeVFiled.frame = CGRectMake(self.view.frame.size.width/2 - sirinaPolja/2, CGRectGetMaxY(self.tvUzina2.frame), sirinaPolja, 45);
    self.tvVecera.frame = CGRectMake(0, CGRectGetMaxY(self.vremeVFiled.frame) , self.scrollView.frame.size.width, 200);

//    self.tvDorucak.text = @" ";
//    self.tvUzina.text = @" ";
//    self.tvRucak.text = @" ";
//    self.tvUzina2.text = @" ";
//    self.tvVecera.text = @" ";
    
    self.tvUzina.textAlignment = NSTextAlignmentRight;
    self.tvUzina2.textAlignment = NSTextAlignmentRight;
    
    self.vremeDFiled.textAlignment = NSTextAlignmentCenter;
    self.vremeUFiled.textAlignment = NSTextAlignmentCenter;
    self.vremeRFiled.textAlignment = NSTextAlignmentCenter;
    self.vremeU2Filed.textAlignment = NSTextAlignmentCenter;
    self.vremeVFiled.textAlignment = NSTextAlignmentCenter;
    
    [MTSupport setDoneOnKeyboard:self.tvDorucak withDoneSelector:@selector(doneClicked:) withObject:self];
    [MTSupport setDoneOnKeyboard:self.tvUzina withDoneSelector:@selector(doneClicked:) withObject:self];
    [MTSupport setDoneOnKeyboard:self.tvRucak withDoneSelector:@selector(doneClicked:) withObject:self];
    [MTSupport setDoneOnKeyboard:self.tvUzina2 withDoneSelector:@selector(doneClicked:) withObject:self];
    [MTSupport setDoneOnKeyboard:self.tvVecera withDoneSelector:@selector(doneClicked:) withObject:self];
    
    [MTSupport setNumericKeyboardWithDone:self.vremeDFiled withDoneSelector:@selector(doneClicked:) withObject:self];
    [MTSupport setNumericKeyboardWithDone:self.vremeUFiled withDoneSelector:@selector(doneClicked:) withObject:self];
    [MTSupport setNumericKeyboardWithDone:self.vremeRFiled withDoneSelector:@selector(doneClicked:) withObject:self];
    [MTSupport setNumericKeyboardWithDone:self.vremeU2Filed withDoneSelector:@selector(doneClicked:) withObject:self];
    [MTSupport setNumericKeyboardWithDone:self.vremeVFiled withDoneSelector:@selector(doneClicked:) withObject:self];

    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 5*self.tvDorucak.frame.size.height+5*self.vremeDFiled.frame.size.height);
    [self.view addSubview:_scrollView];

    UISwipeGestureRecognizer * swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
    swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeleft];
    
    UISwipeGestureRecognizer * swiperight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
    swiperight.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swiperight];
  
}

-(void)segmentSwitch{
    
    [self.view endEditing:YES];
    
    switch (self.pControl.selectedSegmentIndex) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
            self.tvDorucak.placeholder = @"Doručak:";
            self.tvUzina.placeholder = @"Užina:";
            self.tvRucak.placeholder = @"Ručak:";
            self.tvUzina2.placeholder = @"Druga užina:";
            self.tvVecera.placeholder = @"Večera:";
            
            break;
            
        default: break;
    }
}

- (void)keyboardWasShown:(NSNotification *)aNotification {
    NSDictionary *info = [aNotification userInfo];
    CGSize kbSize =  [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.7]; // if you want to slide up the view
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y-kbSize.height/1.2), self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];

}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification *)aNotification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    [self.view setFrame:CGRectMake( 0, 0, self.view.frame.size.width, self.view.frame.size.height-1)];
}

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)deregisterForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{

}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{

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
