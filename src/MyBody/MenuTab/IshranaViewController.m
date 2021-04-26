//
//  IshranaViewController.m
//  MyBody
//
//  Created by Milovan Tomasevic on 29/10/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "IshranaViewController.h"
#import "NYSegmentedControl.h"
#import "IshranaMasterViewController.h"
#import "MarqueeLabel.h"
#import "MarqueeTextField.h"


static const float kMargin = 5 ;
static NSString *cellId = @"CellId";
@interface IshranaViewController ()
@property(nonatomic, strong) NSMutableArray *ishranaOptionsList;
@property(nonatomic) BOOL searchMode;
@end

@implementation IshranaViewController{
    CoreDataManager *coreDataManager;
    AppDelegate *appDelegate;
    NSMutableArray *ishranaList;
    NSArray *searchResults;
    NSString  *userNameMail;
    UILabel *label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *addButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBtnPress:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    self.navigationItem.leftBarButtonItem = button;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    coreDataManager = [[CoreDataManager alloc]init];
    
    ishranaList = [[NSMutableArray alloc] init];
    self.ishranaOptionsList = [[NSMutableArray alloc] init];
    searchResults = [[NSArray alloc] init];
    
    userNameMail = [[NSUserDefaults standardUserDefaults] valueForKey:PREF_USER_EMAIL];
    
    self.customTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.frame.size.width, self.view.frame.size.height - (self.navigationController.navigationBar.frame.size.height+(self.tabBarController.tabBar.frame.size.height)+[[UIApplication sharedApplication] statusBarFrame].size.height))];
    
    
    self.customTableView.backgroundColor = [UIColor clearColor];
    [self.customTableView setSeparatorColor:[UIColor blackColor]];
    self.customTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.customTableView.delegate = self;
    self.customTableView.dataSource = self;
    [self.view addSubview:self.customTableView];
    
    label = [[UILabel alloc] init];
    [label setText:NSLocalizedString(@"Kreirajte novu ishranu...",nil)];
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    [label setCenter: CGPointMake(self.view.center.x, self.view.center.y)];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
    if([userNameMail isEqualToString:@"Admin"]){
        ishranaList = [NSMutableArray arrayWithArray: coreDataManager.getAllIshrane];
    }else{
        ishranaList = [NSMutableArray arrayWithArray: [coreDataManager getAllIshraneForUserEmail:userNameMail]];
    }


    [self performSelector:@selector(refresh:) withObject:self afterDelay:0.5];
    
    if (ishranaList.count<1) {
        [self.view addSubview:label];
    }else{
        [label removeFromSuperview];
    }
}

- (void) refresh:(id)sender
{
    [self.customTableView reloadData];
    if (ishranaList.count<1) {
        [self.view addSubview:label];
    }else{
        [label removeFromSuperview];
    }
}



-(void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    switch(orientation)
    {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
        {
            [self.customTableView reloadData];
            
            break;
        }
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationPortraitUpsideDown:
        {
            [self.customTableView reloadData];
            break;
        }
        default: {
            break;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return ishranaList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITextField *textField;
    
    UITableViewCell *tableCell = [self.customTableView dequeueReusableCellWithIdentifier:cellId];
    //[tableCell setAccessoryType:UITableViewCellAccessoryNone];
    // selection
    [tableCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (tableCell == nil) {
        tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    tableCell.backgroundColor = [UIColor clearColor];
    
    UIView *containerView;
    containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableCell.frame.size.width, tableCell.frame.size.height)];
    [containerView setBackgroundColor:[UIColor lightGrayColor]];
    
    int tag = (int)(indexPath.section);
    
    Ishrana *ish  = [ishranaList objectAtIndex:tag];
    
    UILabel *labelName = [[MarqueeLabel alloc]initWithFrame:CGRectMake(kMargin, kMargin, (tableCell.frame.size.width)/4 - (2*kMargin), (tableCell.frame.size.height)/2- (2*kMargin))];
    labelName.textAlignment = NSTextAlignmentCenter;
    labelName.text = NSLocalizedString(@"Ime: ",nil);
    labelName.textColor = [UIColor blackColor];
    labelName.numberOfLines = 1;
    [labelName setBackgroundColor:[ UIColor grayColor]];
    [labelName setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    [containerView addSubview:labelName];
    
    textField = [[MarqueeTextField alloc]initWithFrame:CGRectMake(kMargin + (tableCell.frame.size.width)/4, kMargin, (3*(tableCell.frame.size.width)/4) - (2*kMargin), (tableCell.frame.size.height)/2- (2*kMargin) )];
    textField.userInteractionEnabled = NO;
    textField.text = ish.ime;
    textField.layer.cornerRadius = kButtonDefCornerRadius;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.textColor = [UIColor whiteColor];
    [textField setBackgroundColor:[UIColor grayColor]];
    [containerView addSubview:textField];
    
    UIButton *defTrening = [UIButton buttonWithType:UIButtonTypeCustom];
    [defTrening setFrame:CGRectMake(kMargin, CGRectGetMaxY(labelName.frame)+kMargin, (tableCell.frame.size.width)/2-(2*kMargin), (tableCell.frame.size.height)/2 - (2*kMargin))];
    [defTrening setTitle:NSLocalizedString(@"Podrazumevana",nil) forState:UIControlStateNormal];
    defTrening.layer.cornerRadius = kButtonDefCornerRadius;
    [defTrening setTag:tag];
    [defTrening addTarget:self action:@selector(setDelaultIshrana:) forControlEvents:UIControlEventTouchUpInside];
    [defTrening setBackgroundColor: [ UIColor orangeColor]];
    [containerView addSubview: defTrening];
    
    UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [infoBtn setFrame:CGRectMake( kMargin+ CGRectGetMaxX(defTrening.frame), CGRectGetMaxY(labelName.frame)+kMargin, (tableCell.frame.size.width)/2 - kMargin, (tableCell.frame.size.height)/2 - (2*kMargin))];
    [infoBtn setTitle:NSLocalizedString(@"info",nil) forState:UIControlStateNormal];
    infoBtn.layer.cornerRadius = kButtonDefCornerRadius;
    [infoBtn setTag:tag];
    [infoBtn addTarget:self action:@selector(infoButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [infoBtn setBackgroundColor: [ UIColor orangeColor]];
    [containerView addSubview: infoBtn];
    [tableCell.contentView addSubview: containerView];
    
    tableCell.layer.borderWidth = 3;
    tableCell.layer.borderColor = [THEME_MANAGER getBackgroundColor].CGColor;
    
    return tableCell;
}

- (CGFloat)tableView:(UITableView* )tableView heightForRowAtIndexPath:(NSIndexPath* )indexPath{
    
    return 100;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        int tag = (int)(indexPath.section);
        
        Ishrana *ish = [ishranaList objectAtIndex:tag];
        [ishranaList removeObjectAtIndex:tag];
        [self.customTableView reloadData];
        [coreDataManager removeIshranaWithName:ish.ime];
        [appDelegate saveContext];
        
        [MTSupport progressDone:@"Ishrana obrisana!" andView:self.navigationController.view];
        if (ishranaList.count<1) {
            [self.view addSubview:label];
        }
    }
}


-(void)setDelaultIshrana:(UIButton*)sender
{
    LogI(@"setDelaultIshrana button clicked");
    
    // set all defaults =  NO
    for (Ishrana *ish in  [coreDataManager getAllIshrane]) {
        [ish setIzabranaIshrana:NO];
    }
    
    // set current ishrana for Default YES
    Ishrana *ish = [ishranaList objectAtIndex:sender.tag];
    [ish setIzabranaIshrana:YES];
    [appDelegate saveContext];
    
    [self.customTableView reloadData];
    
    [MTSupport progressDone:@"Postavljena kao podrazumevan." andView:self.navigationController.view];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return NO;
}

-(void)infoButtonClicked:(UIButton*)sender
{
    LogI(@"Info button clicked");
    Ishrana *ish = [ishranaList objectAtIndex:sender.tag];
    
    [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"Brzi pregled",nil) message:[NSString stringWithFormat:NSLocalizedString(@"detalis_ishrana",nil), ish.ime, ish.datumUnosa, ish.vremeDorucka, ish.vremeUzine, ish.vremeRucka, ish.vremeUzine2, ish.vremeVecere, ish.pDorucak, ish.uUzina, ish.sRucak, ish.cUzina2,ish.petVecera, ish.izabranaIshrana]];
}

-(void)addBtnPress:(UIBarButtonItem*)item{
    IshranaMasterViewController *ishranaMVC = [[IshranaMasterViewController alloc] init];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:ishranaMVC animated:YES];
}

@end
