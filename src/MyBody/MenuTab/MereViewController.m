//
//  MereViewController.m
//  MyBody
//
//  Created by Milovan Tomasevic on 29/10/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "MereViewController.h"
#import "UIFloatLabelTextField.h"
#import "NewMereViewController.h"
#import "MarqueeLabel.h"
#import "MarqueeTextField.h"

static const float kMargin = 5 ;
static NSString *cellId = @"CellId";

@interface MereViewController ()
@property(nonatomic, strong) NSMutableArray *mereOptionsList;
@property(nonatomic) BOOL searchMode;
@end


@implementation MereViewController{
    CoreDataManager *coreDataManager;
    AppDelegate *appDelegate;
    NSMutableArray *mereList;
    NSArray *searchResults;
    NSString  *userNameMail;
    UILabel *label;
}

@synthesize customTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadPage];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    
    if([userNameMail isEqualToString:@"Admin"]){
        mereList = [NSMutableArray arrayWithArray: coreDataManager.getAllMere];
    }else{
        mereList = [NSMutableArray arrayWithArray: [coreDataManager getAllMereForUserEmail:userNameMail]];
    }

    [self performSelector:@selector(refresh:) withObject:self afterDelay:0.1];
    if (mereList.count<1) {
        [self.view addSubview:label];
    }else{
        [label removeFromSuperview];
    }
}

- (void) refresh:(id)sender
{
    [self.customTableView reloadData];
    if (mereList.count<1) {
        [self.view addSubview:label];
    }else{
        [label removeFromSuperview];
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return mereList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITextField *imeMereField;
    
    
    UITableViewCell *tableCell = [self.customTableView dequeueReusableCellWithIdentifier:cellId];
    [tableCell setAccessoryType:UITableViewCellAccessoryNone];
    // selection
    [tableCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (tableCell == nil) {
        tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        //cell = [cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    tableCell.backgroundColor = [UIColor clearColor];
    
    UIView *containerView;
    containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    [containerView setBackgroundColor:[UIColor lightGrayColor]];
    
    int tag = (int)(indexPath.section);
    
    Mere *m  = [mereList objectAtIndex:tag];
    
    CGFloat sirinaCell = tableCell.frame.size.width;
    CGFloat visinaCell = tableCell.frame.size.height;
    
    UILabel *labelName = [[MarqueeLabel alloc]initWithFrame:CGRectMake(kMargin, kMargin, sirinaCell/4 - (2*kMargin), visinaCell/3- (2*kMargin))];
    [self customizeLabel:labelName withText:@"Ime:" andView:containerView];
    
    
    
    imeMereField = [[MarqueeTextField alloc]initWithFrame:CGRectMake(kMargin + sirinaCell/4, kMargin, (3*sirinaCell/4) - (2*kMargin), visinaCell/3- (2*kMargin) )];
    [self customizeField:imeMereField withText:m.ime andView:containerView];
    
    UILabel *labelDatum = [[MarqueeLabel alloc]initWithFrame:CGRectMake(kMargin, CGRectGetMaxY(imeMereField.frame)+kMargin, sirinaCell/3-(2*kMargin), visinaCell/3 - (2*kMargin))];

    [self customizeLabel:labelDatum withText:@"Datum merenja:" andView:containerView];
    
    UITextField *datumField = [[MarqueeTextField alloc]initWithFrame:CGRectMake( kMargin+ CGRectGetMaxX(labelDatum.frame), CGRectGetMaxY(labelName.frame)+kMargin, sirinaCell/3 - kMargin, visinaCell/3 - (2*kMargin))];
    [self customizeField:datumField withText:m.datumMerenja andView:containerView];

    UILabel *labelTezina = [[MarqueeLabel alloc]initWithFrame:CGRectMake(kMargin+ CGRectGetMaxX(datumField.frame), CGRectGetMaxY(imeMereField.frame)+kMargin, sirinaCell/6-(2*kMargin), visinaCell/3 - (2*kMargin))];
    [self customizeLabel:labelTezina withText:@"Tezina:" andView:containerView];
    
    UITextField *tezinaField = [[MarqueeTextField alloc]initWithFrame:CGRectMake( kMargin+ CGRectGetMaxX(labelTezina.frame), CGRectGetMaxY(labelName.frame)+kMargin, sirinaCell/6 - kMargin, visinaCell/3 - (2*kMargin))];
    [self customizeField:tezinaField withText:m.tezina andView:containerView];

    UIButton *defTrening = [UIButton buttonWithType:UIButtonTypeCustom];
    [defTrening setFrame:CGRectMake(kMargin, CGRectGetMaxY(labelDatum.frame)+kMargin, sirinaCell/2-(2*kMargin), (tableCell.frame.size.height)/3 - (2*kMargin))];
    [defTrening setTitle:NSLocalizedString(@"Podrazumevana",nil) forState:UIControlStateNormal];
    defTrening.layer.cornerRadius = kButtonDefCornerRadius;
    [defTrening setTag:tag];
    [defTrening addTarget:self action:@selector(setDelaultTrening:) forControlEvents:UIControlEventTouchUpInside];
    [defTrening setBackgroundColor: [ UIColor orangeColor]];
    [containerView addSubview: defTrening];

    UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [infoBtn setFrame:CGRectMake( kMargin+ CGRectGetMaxX(defTrening.frame), CGRectGetMaxY(labelDatum.frame)+kMargin, sirinaCell/2 - kMargin, (tableCell.frame.size.height)/3 - (2*kMargin))];
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
    
    return 150;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        int tag = (int)(indexPath.section);
        
        Mere *m = [mereList objectAtIndex:tag];
        [mereList removeObjectAtIndex:tag];
        [self.customTableView reloadData];
        [coreDataManager removeMereWithName:m.ime];
        [appDelegate saveContext];
        
        [MTSupport progressDone:@"Mera obrisana!" andView:self.navigationController.view];
        if (mereList.count<1) {
            [self.view addSubview:label];
        }
    }
}


-(void)setDelaultTrening:(UIButton*)sender
{
    LogI(@"setDelaultTrening button clicked");
    
    // set all defaults =  NO
    for (Mere *m in  [coreDataManager getAllMere]) {
        [m setIzabranaMera:NO];
    }
    
    // set current trening for Default YES
    Mere *m = [mereList objectAtIndex:sender.tag];
    [m setIzabranaMera:YES];
    [appDelegate saveContext];
    
    [self.customTableView reloadData];
    
    [MTSupport progressDone:@"Postavljena kao podrazumevana." andView:self.navigationController.view];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return NO;
}

-(void)infoButtonClicked:(UIButton*)sender
{
    LogI(@"Info button clicked");
    Mere *m = [mereList objectAtIndex:sender.tag];
    
    [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"Brzi pregled",nil) message:[NSString stringWithFormat:NSLocalizedString(@"detalis_mere",nil), m.ime, m.datumMerenja, m.pol, m.godine, m.visina, m.tezina, m.obimKuka, m.obimGrudi, m.obimButina, m.bmi, m.kratkaNapomena, m.izabranaMera]];
}


-(void)loadPage{
    UIBarButtonItem *addButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBtnPress:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    self.navigationItem.leftBarButtonItem = button;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    coreDataManager = [[CoreDataManager alloc]init];
    
    mereList = [[NSMutableArray alloc] init];
    self.mereOptionsList = [[NSMutableArray alloc] init];
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
    [label setText:NSLocalizedString(@"Kreirajte novu meru...",nil)];
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    [label setCenter: CGPointMake(self.view.center.x, self.view.center.y)];
}

-(void)addBtnPress:(UIBarButtonItem*)item{
    
    NewMereViewController *newMereVC = [[NewMereViewController alloc] init];
    [newMereVC setTitle:[NSString stringWithFormat:@"MERENJE"]];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:newMereVC animated:YES];
}




-(void)customizeField:(UITextField*)field withText:(NSString*)text andView:(UIView*)view{

    field.userInteractionEnabled = NO;
    field.text = text;
    field.layer.cornerRadius = kButtonDefCornerRadius;
    field.textAlignment = NSTextAlignmentCenter;
    field.textColor = [UIColor whiteColor];
    [field setBackgroundColor:[UIColor grayColor]];
    [view addSubview:field];
}

-(void)customizeLabel:(UILabel*)label withText:(NSString*)text andView:(UIView*)view{
    label.textAlignment = NSTextAlignmentCenter;
    label.text = NSLocalizedString(text, nil);
    label.textColor = [UIColor blackColor];
    label.numberOfLines = 1;
    [label setBackgroundColor:[ UIColor grayColor]];
    [label setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    [view addSubview:label];
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


@end
