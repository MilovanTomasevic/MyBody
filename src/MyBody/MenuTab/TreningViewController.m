//
//  TreningViewController.m
//  MyBody
//
//  Created by Milovan Tomasevic on 29/10/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "TreningViewController.h"
#import "TreningMasterViewController.h"
#import "MarqueeLabel.h"
#import "MarqueeTextField.h"


static const float kMargin = 5 ;
static NSString *cellId = @"CellId";

@interface TreningViewController ()
//@property(nonatomic, strong) UITableView *customTableView;
@property(nonatomic, strong) NSMutableArray *treninziOptionsList;
@property(nonatomic) BOOL searchMode;

@end

@implementation TreningViewController{
    CoreDataManager *coreDataManager;
    AppDelegate *appDelegate;
    NSMutableArray *treninziList;
    NSArray *searchResults;
    NSString  *userNameMail;
    UILabel *label;
}

@synthesize customTableView;

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *addButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBtnPress:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    self.navigationItem.leftBarButtonItem = button;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    coreDataManager = [[CoreDataManager alloc]init];
    
    treninziList = [[NSMutableArray alloc] init];
    self.treninziOptionsList = [[NSMutableArray alloc] init];
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
    [label setText:NSLocalizedString(@"Kreirajte novi trening...",nil)];
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    [label setCenter: CGPointMake(self.view.center.x, self.view.center.y)];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    
    if([userNameMail isEqualToString:@"Admin"]){
        treninziList = [NSMutableArray arrayWithArray: coreDataManager.getAllTreninge];
    }else{
        treninziList = [NSMutableArray arrayWithArray: [coreDataManager getAllTreningeForUserEmail:userNameMail]];
    }

    [self performSelector:@selector(refresh:) withObject:self afterDelay:0.1];
    
    if (treninziList.count<1) {
        [self.view addSubview:label];
    }else{
        [label removeFromSuperview];
    }
}

- (void) refresh:(id)sender
{
    [self.customTableView reloadData];
    if (treninziList.count<1) {
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
    return treninziList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITextField *textField;
    
    UITableViewCell *tableCell = [self.customTableView dequeueReusableCellWithIdentifier:cellId];
    [tableCell setAccessoryType:UITableViewCellAccessoryNone];
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
    
    Trening *tre  = [treninziList objectAtIndex:tag];
    
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
    textField.text = tre.ime;
    textField.layer.cornerRadius = kButtonDefCornerRadius;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.textColor = [UIColor whiteColor];
    [textField setBackgroundColor:[UIColor grayColor]];
    [containerView addSubview:textField];

    UIButton *defTrening = [UIButton buttonWithType:UIButtonTypeCustom];
    [defTrening setFrame:CGRectMake(kMargin, CGRectGetMaxY(labelName.frame)+kMargin, (tableCell.frame.size.width)/2-(2*kMargin), (tableCell.frame.size.height)/2 - (2*kMargin))];
    [defTrening setTitle:NSLocalizedString(@"Podrazumevani",nil) forState:UIControlStateNormal];
    defTrening.layer.cornerRadius = kButtonDefCornerRadius;
    [defTrening setTag:tag];
    [defTrening addTarget:self action:@selector(setDelaultTrening:) forControlEvents:UIControlEventTouchUpInside];
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
        
        Trening *tre = [treninziList objectAtIndex:tag];
        [treninziList removeObjectAtIndex:tag];
        [self.customTableView reloadData];
        [coreDataManager removeTreningWithName:tre.ime];
        [appDelegate saveContext];

        [MTSupport progressDone:@"Trening obrisan!" andView:self.navigationController.view];
        if (treninziList.count<1) {
            [self.view addSubview:label];
        }
    }
}


-(void)setDelaultTrening:(UIButton*)sender
{
    LogI(@"setDelaultTrening button clicked");
    
    // set all defaults =  NO
    for (Trening *tre in  [coreDataManager getAllTreninge]) {
        [tre setIzabraniTrening:NO];
    }
    
    // set current trening for Default YES
    Trening *tre = [treninziList objectAtIndex:sender.tag];
    [tre setIzabraniTrening:YES];
    [appDelegate saveContext];
    
    [self.customTableView reloadData];
    
    [MTSupport progressDone:@"Postavljen kao podrazumevan." andView:self.navigationController.view];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return NO;
}

-(void)infoButtonClicked:(UIButton*)sender
{
    LogI(@"Info button clicked");
    Trening *tre = [treninziList objectAtIndex:sender.tag];
    
    [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"Brzi pregled",nil) message:[NSString stringWithFormat:NSLocalizedString(@"detalis_trening",nil), tre.ime, tre.datumUnosa, tre.t1Sadrzaj, tre.t2Sadrzaj, tre.t3Sadrzaj, tre.t4Sadrzaj, tre.t5Sadrzaj, tre.t6Sadrzaj, tre.t7Sadrzaj, tre.izabraniTrening]];
}


-(void)addBtnPress:(UIBarButtonItem*)item{
    TreningMasterViewController *treningMVC = [[TreningMasterViewController alloc] init];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:treningMVC animated:YES];
}

@end
