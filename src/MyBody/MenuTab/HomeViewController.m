//
//  DefaultViewController.m
//  MyBody
//
//  Created by Milovan Tomasevic on 29/10/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "HomeViewController.h"
#import "NYSegmentedControl.h"
#import "WCSTimelineCell.h"

@interface HomeViewController ()
@property (nonatomic, strong) UIRefreshControl * refreshControl;
//@property (nonatomic, weak) IBOutlet UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * timelineData;

@end

@implementation HomeViewController{
    NSString *userMail;
}

@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.coreDataManager = [[CoreDataManager alloc]init];
    self.dbIshrana = [self.coreDataManager getNewIshrana];
    self.dbTrening = [self.coreDataManager getNewTrening];
    self.dbMere = [self.coreDataManager getNewMere];
    
    [self loadPage];

    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.frame.size.width, self.view.frame.size.height - (self.navigationController.navigationBar.frame.size.height+(self.tabBarController.tabBar.frame.size.height)+[[UIApplication sharedApplication] statusBarFrame].size.height))];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorColor:[UIColor blackColor]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor =[THEME_MANAGER getAccentColor];
    self.refreshControl.backgroundColor = [UIColor whiteColor];
    self.tableView.refreshControl = self.refreshControl;
    [self.refreshControl addTarget:self action:@selector(reloadTimeline) forControlEvents:UIControlEventValueChanged];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
    userMail = [[NSUserDefaults standardUserDefaults] valueForKey:PREF_USER_EMAIL];
    
    self.dbIshrana = [self.coreDataManager getIzabranaIshranaForUserEmail:userMail];
    self.dbTrening = [self.coreDataManager getIzabraniTreningForUserEmail:userMail];
    self.dbMere = [self.coreDataManager getIzabranaMeraForUserEmail:userMail];
    
    [self segmentSwitch:self.segmentedControl];

}



- (IBAction)segmentSwitch:(NYSegmentedControl *)sender {
    
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            
            if (self.dbIshrana) {
                [self ishranaSetup];
                [tableView reloadData];
            }
            
            break;
        case 1:
            
            if (self.dbTrening) {
                [self treningSetup];
                [tableView reloadData];
            }

            break;
        case 2:
            
            if (self.dbMere) {
                [self mereSetup];
                [tableView reloadData];
            }
           
            break;

        default: break;
    }
}


////////////////           TIME-LINE TABLE        /////////////////////////


///*********************** TRENING SETUP   *****************************


-(void)treningSetup{
    
    self.timelineData = nil;
    self.timelineData = [NSMutableArray new];

    
    WCSTimelineModel * modelPon = [WCSTimelineModel new];
    [self dataTimeLine:modelPon time:@"Pon" title:self.dbTrening.t1Fokus state:WCSStateUnknown content:self.dbTrening.t1Sadrzaj];
    
    WCSTimelineModel * modelUto = [WCSTimelineModel new];
    [self dataTimeLine:modelUto time:@"Uto" title:self.dbTrening.t2Fokus state:WCSStateUnknown content:self.dbTrening.t2Sadrzaj];
    
    WCSTimelineModel * modelSre = [WCSTimelineModel new];
    [self dataTimeLine:modelSre time:@"Sre" title:self.dbTrening.t3Fokus state:WCSStateUnknown content:self.dbTrening.t3Sadrzaj];
    
    WCSTimelineModel * modelCet = [WCSTimelineModel new];
    [self dataTimeLine:modelCet time:@"Cet" title:self.dbTrening.t4Fokus state:WCSStateUnknown content:self.dbTrening.t4Sadrzaj];
    
    WCSTimelineModel * modelPet = [WCSTimelineModel new];
    [self dataTimeLine:modelPet time:@"Pet" title:self.dbTrening.t5Fokus state:WCSStateUnknown content:self.dbTrening.t5Sadrzaj];
    
    WCSTimelineModel * modelSub = [WCSTimelineModel new];
    [self dataTimeLine:modelSub time:@"Sub" title:self.dbTrening.t6Fokus state:WCSStateUnknown content:self.dbTrening.t6Sadrzaj];
    
    WCSTimelineModel * modelNed = [WCSTimelineModel new];
    [self dataTimeLine:modelNed time:@"Ned" title:self.dbTrening.t7Fokus state:WCSStateUnknown content:self.dbTrening.t7Sadrzaj];

}

///*********************** TRENING SETUP   *****************************

///*********************** Ishrana SETUP   *****************************


-(void)ishranaSetup{
    
    self.timelineData = nil;
    self.timelineData = [NSMutableArray new];
    
    
    WCSTimelineModel * modelPon = [WCSTimelineModel new];
    [self dataTimeLine:modelPon time:@"Pon" title:[NSString stringWithFormat:@"U %@h Dorucak", self.dbIshrana.vremeDorucka]  state:WCSStateActive content:self.dbIshrana.pDorucak];

    WCSTimelineModel * modelPon2 = [WCSTimelineModel new];
    [self dataTimeLine:modelPon2 time:@"Pon" title:[NSString stringWithFormat:@"U %@h Uzina", self.dbIshrana.vremeUzine] state:WCSStateInactive content:self.dbIshrana.pUzina];

    WCSTimelineModel * modelPon3 = [WCSTimelineModel new];
    [self dataTimeLine:modelPon3 time:@"Pon" title:[NSString stringWithFormat:@"U %@h Rucak", self.dbIshrana.vremeRucka]  state:WCSStateActive content:self.dbIshrana.pRucak];

    WCSTimelineModel * modelPon4 = [WCSTimelineModel new];
    [self dataTimeLine:modelPon4 time:@"Pon" title:[NSString stringWithFormat:@"U %@h Druga uzina", self.dbIshrana.vremeUzine2]  state:WCSStateInactive content:self.dbIshrana.pUzina2];

    WCSTimelineModel * modelPon5 = [WCSTimelineModel new];
    [self dataTimeLine:modelPon5 time:@"Pon" title:[NSString stringWithFormat:@"U %@h Vecera", self.dbIshrana.vremeVecere]  state:WCSStateUnknown content:self.dbIshrana.pVecera];
    
    
    WCSTimelineModel * modelUto = [WCSTimelineModel new];
    [self dataTimeLine:modelUto time:@"Uto" title:[NSString stringWithFormat:@"U %@h Dorucak", self.dbIshrana.vremeDorucka]  state:WCSStateActive content:self.dbIshrana.uDorucak];
    
    WCSTimelineModel * modelUto2 = [WCSTimelineModel new];
    [self dataTimeLine:modelUto2 time:@"Uto" title:[NSString stringWithFormat:@"U %@h Uzina", self.dbIshrana.vremeUzine] state:WCSStateInactive content:self.dbIshrana.uUzina];
    
    WCSTimelineModel * modelUto3 = [WCSTimelineModel new];
    [self dataTimeLine:modelUto3 time:@"Uto" title:[NSString stringWithFormat:@"U %@h Rucak", self.dbIshrana.vremeRucka]  state:WCSStateActive content:self.dbIshrana.uRucak];
    
    WCSTimelineModel * modelUto4 = [WCSTimelineModel new];
    [self dataTimeLine:modelUto4 time:@"Uto" title:[NSString stringWithFormat:@"U %@h Druga uzina", self.dbIshrana.vremeUzine2]  state:WCSStateInactive content:self.dbIshrana.uUzina2];
    
    WCSTimelineModel * modelUto5 = [WCSTimelineModel new];
    [self dataTimeLine:modelUto5 time:@"Uto" title:[NSString stringWithFormat:@"U %@h Vecera", self.dbIshrana.vremeVecere]  state:WCSStateUnknown content:self.dbIshrana.uVecera];
    
    
    WCSTimelineModel * modelSre = [WCSTimelineModel new];
    [self dataTimeLine:modelSre time:@"Sre" title:[NSString stringWithFormat:@"U %@h Dorucak", self.dbIshrana.vremeDorucka]  state:WCSStateActive content:self.dbIshrana.sDorucak];
    
    WCSTimelineModel * modelSre2 = [WCSTimelineModel new];
    [self dataTimeLine:modelSre2 time:@"Sre" title:[NSString stringWithFormat:@"U %@h Uzina", self.dbIshrana.vremeUzine] state:WCSStateInactive content:self.dbIshrana.sUzina];
    
    WCSTimelineModel * modelSre3 = [WCSTimelineModel new];
    [self dataTimeLine:modelSre3 time:@"Sre" title:[NSString stringWithFormat:@"U %@h Rucak", self.dbIshrana.vremeRucka]  state:WCSStateActive content:self.dbIshrana.sRucak];
    
    WCSTimelineModel * modelSre4 = [WCSTimelineModel new];
    [self dataTimeLine:modelSre4 time:@"Sre" title:[NSString stringWithFormat:@"U %@h Druga uzina", self.dbIshrana.vremeUzine2]  state:WCSStateInactive content:self.dbIshrana.sUzina2];
    
    WCSTimelineModel * modelSre5 = [WCSTimelineModel new];
    [self dataTimeLine:modelSre5 time:@"Sre" title:[NSString stringWithFormat:@"U %@h Vecera", self.dbIshrana.vremeVecere]  state:WCSStateUnknown content:self.dbIshrana.sVecera];
    
    
    WCSTimelineModel * modelCet = [WCSTimelineModel new];
    [self dataTimeLine:modelCet time:@"Cet" title:[NSString stringWithFormat:@"U %@h Dorucak", self.dbIshrana.vremeDorucka]  state:WCSStateActive content:self.dbIshrana.cDorucak];
    
    WCSTimelineModel * modelCet2 = [WCSTimelineModel new];
    [self dataTimeLine:modelCet2 time:@"Cet" title:[NSString stringWithFormat:@"U %@h Uzina", self.dbIshrana.vremeUzine] state:WCSStateInactive content:self.dbIshrana.cUzina];
    
    WCSTimelineModel * modelCet3 = [WCSTimelineModel new];
    [self dataTimeLine:modelCet3 time:@"Cet" title:[NSString stringWithFormat:@"U %@h Rucak", self.dbIshrana.vremeRucka]  state:WCSStateActive content:self.dbIshrana.cRucak];
    
    WCSTimelineModel * modelCet4 = [WCSTimelineModel new];
    [self dataTimeLine:modelCet4 time:@"Cet" title:[NSString stringWithFormat:@"U %@h Druga uzina", self.dbIshrana.vremeUzine2]  state:WCSStateInactive content:self.dbIshrana.cUzina2];
    
    WCSTimelineModel * modelCet5 = [WCSTimelineModel new];
    [self dataTimeLine:modelCet5 time:@"Cet" title:[NSString stringWithFormat:@"U %@h Vecera", self.dbIshrana.vremeUzine]  state:WCSStateUnknown content:self.dbIshrana.cVecera];
    
    

    WCSTimelineModel * modelPet = [WCSTimelineModel new];
    [self dataTimeLine:modelPet time:@"Pet" title:[NSString stringWithFormat:@"U %@h Dorucak", self.dbIshrana.vremeDorucka]  state:WCSStateActive content:self.dbIshrana.petDorucak];
    
    WCSTimelineModel * modelPet2 = [WCSTimelineModel new];
    [self dataTimeLine:modelPet2 time:@"Pet" title:[NSString stringWithFormat:@"U %@h Uzina", self.dbIshrana.vremeUzine] state:WCSStateInactive content:self.dbIshrana.petUzina];
    
    WCSTimelineModel * modelPet3 = [WCSTimelineModel new];
    [self dataTimeLine:modelPet3 time:@"Pet" title:[NSString stringWithFormat:@"U %@h Rucak", self.dbIshrana.vremeRucka]  state:WCSStateActive content:self.dbIshrana.petRucak];
    
    WCSTimelineModel * modelPet4 = [WCSTimelineModel new];
    [self dataTimeLine:modelPet4 time:@"Pet" title:[NSString stringWithFormat:@"U %@h Druga uzina", self.dbIshrana.vremeUzine2]  state:WCSStateInactive content:self.dbIshrana.petUzina2];
    
    WCSTimelineModel * modelPet5 = [WCSTimelineModel new];
    [self dataTimeLine:modelPet5 time:@"Pet" title:[NSString stringWithFormat:@"U %@h Vecera", self.dbIshrana.vremeVecere]  state:WCSStateUnknown content:self.dbIshrana.petVecera];
    
    
    WCSTimelineModel * modelSub = [WCSTimelineModel new];
    [self dataTimeLine:modelSub time:@"Sub" title:[NSString stringWithFormat:@"U %@h Dorucak", self.dbIshrana.vremeDorucka]  state:WCSStateActive content:self.dbIshrana.subDorucak];
    
    WCSTimelineModel * modelSub2 = [WCSTimelineModel new];
    [self dataTimeLine:modelSub2 time:@"Sub" title:[NSString stringWithFormat:@"U %@h Uzina", self.dbIshrana.vremeUzine] state:WCSStateInactive content:self.dbIshrana.subUzina];
    
    WCSTimelineModel * modelSub3 = [WCSTimelineModel new];
    [self dataTimeLine:modelSub3 time:@"Sub" title:[NSString stringWithFormat:@"U %@h Rucak", self.dbIshrana.vremeRucka]  state:WCSStateActive content:self.dbIshrana.subRucak];
    
    WCSTimelineModel * modelSub4 = [WCSTimelineModel new];
    [self dataTimeLine:modelSub4 time:@"Sub" title:[NSString stringWithFormat:@"U %@h Druga uzina", self.dbIshrana.vremeUzine2]  state:WCSStateInactive content:self.dbIshrana.subUzina2];
    
    WCSTimelineModel * modelSub5 = [WCSTimelineModel new];
    [self dataTimeLine:modelSub5 time:@"Sub" title:[NSString stringWithFormat:@"U %@h Vecera", self.dbIshrana.vremeVecere]  state:WCSStateUnknown content:self.dbIshrana.subVecera];
    
    
    WCSTimelineModel * modelNed = [WCSTimelineModel new];
    [self dataTimeLine:modelNed time:@"Ned" title:[NSString stringWithFormat:@"U %@h Dorucak", self.dbIshrana.vremeDorucka]  state:WCSStateActive content:self.dbIshrana.nDorucak];
    
    WCSTimelineModel * modelNed2 = [WCSTimelineModel new];
    [self dataTimeLine:modelNed2 time:@"Ned" title:[NSString stringWithFormat:@"U %@h Uzina", self.dbIshrana.vremeUzine] state:WCSStateInactive content:self.dbIshrana.nUzina];
    
    WCSTimelineModel * modelNed3 = [WCSTimelineModel new];
    [self dataTimeLine:modelNed3 time:@"Ned" title:[NSString stringWithFormat:@"U %@h Rucak", self.dbIshrana.vremeRucka]  state:WCSStateActive content:self.dbIshrana.nRucak];
    
    WCSTimelineModel * modelNed4 = [WCSTimelineModel new];
    [self dataTimeLine:modelNed4 time:@"Ned" title:[NSString stringWithFormat:@"U %@h Druga uzina", self.dbIshrana.vremeUzine2]  state:WCSStateInactive content:self.dbIshrana.nUzina2];
    
    WCSTimelineModel * modelNed5 = [WCSTimelineModel new];
    [self dataTimeLine:modelNed5 time:@"Ned" title:[NSString stringWithFormat:@"U %@h Vecera", self.dbIshrana.vremeVecere]  state:WCSStateUnknown content:self.dbIshrana.nVecera];
    
    
    NSLog(@"ovo je dorucak %@",self.dbIshrana.pDorucak );
    

    
    
    
    
    
}

///*********************** Ishrana SETUP   *****************************
///*********************** MERE SETUP   *****************************


-(void)mereSetup{
    
    self.timelineData = nil;
    self.timelineData = [NSMutableArray new];
    
    
    WCSTimelineModel * modelPon = [WCSTimelineModel new];
    [self dataTimeLine:modelPon time:@"O" title:self.dbMere.ime state:WCSStateActive content:self.dbMere.datumMerenja];
    
    WCSTimelineModel * modelUto = [WCSTimelineModel new];
    [self dataTimeLine:modelUto time:@"D" title:@"Obim kuka" state:WCSStateActive content:self.dbMere.obimKuka];
    
    WCSTimelineModel * modelSre = [WCSTimelineModel new];
    [self dataTimeLine:modelSre time:@"L" title:@"Obim grudi" state:WCSStateActive content:self.dbMere.obimGrudi];
    
    WCSTimelineModel * modelCet = [WCSTimelineModel new];
    [self dataTimeLine:modelCet time:@"I" title:@"Obim butina" state:WCSStateActive content:self.dbMere.obimButina];
    
    WCSTimelineModel * modelPet = [WCSTimelineModel new];
    [self dataTimeLine:modelPet time:@"C" title:@"Tezina 🙈🙉🙊" state:WCSStateActive content:self.dbMere.tezina];
    
    WCSTimelineModel * modelSub = [WCSTimelineModel new];
    [self dataTimeLine:modelSub time:@"N" title:@"BMI" state:WCSStateActive content:self.dbMere.bmi];
    
    WCSTimelineModel * modelNed = [WCSTimelineModel new];
    [self dataTimeLine:modelNed time:@"O" title:@"Komentar" state:WCSStateActive content:self.dbMere.kratkaNapomena];
    
    
}









///*********************** MERE SETUP   *****************************



-(void)dataTimeLine:(WCSTimelineModel*)model time:(NSString*)time title:(NSString*)title state:(WCSState)state content:(NSString*)content {
    model.icon = [UIImage imageNamed:@"event"];
    model.time = time;
    model.event = title;
    model.state = state;
    model.content = content;
    [self.timelineData addObject:model];
}


- (void)reloadTimeline
{

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"kLastRefresh"];
        self.refreshControl.attributedTitle = [self attributedRefreshTitle];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
        });
    });
}


#pragma mark - UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.timelineData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WCSTimelineModel * model = self.timelineData[indexPath.row];
    return model.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"WCSTimelineCell";
    WCSTimelineCell * timelineCell = timelineCell = [[WCSTimelineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    timelineCell.selectionStyle = UITableViewCellSelectionStyleNone;
    timelineCell.backgroundColor = ( indexPath.row % 2 == 0 ? [self hex:@"f2f1f1" alpha:1.f] : [self hex:@"ffffff" alpha:1.f] );
    
    WCSTimelineModel * model = self.timelineData[indexPath.row];
    if (indexPath.row == self.timelineData.count - 1 ) {
        model.isLast = true;
    }
    timelineCell.model = model;
    
    return timelineCell;
}

#pragma mark - Utilities

- (NSDate*)randomDate
{
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDate *now = [NSDate date];
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:now];
    [comps setYear:[comps year] - 1];
    
    NSDate * startDate = [gregorian dateFromComponents:comps];
    NSDate * endDate = [NSDate date];
    
    NSTimeInterval timeBetweenDates = [endDate timeIntervalSinceDate:startDate];
    NSTimeInterval randomInterval = ((NSTimeInterval)arc4random() / ARC4RANDOM_MAX) * timeBetweenDates;
    
    return [startDate dateByAddingTimeInterval:randomInterval];
}

- (NSString*)friendlyDate
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd\'T\'HH:mm:ssZZZZZ";
    formatter.dateStyle = NSDateFormatterMediumStyle;
    formatter.timeStyle = NSDateFormatterMediumStyle;
    
    NSDate * date = [[NSUserDefaults standardUserDefaults] objectForKey:@"kLastRefresh"];
    
    return [formatter stringFromDate:date];
}

- (NSAttributedString*)attributedRefreshTitle
{
    NSString * string1 = @"Last Updated:";
    NSString * string2 = [self friendlyDate];
    
    NSMutableAttributedString * attributedDetails =
    [[NSMutableAttributedString alloc]
     initWithString:[NSString stringWithFormat:@"%@ %@", string1, string2] attributes:nil];
    
    NSMutableAttributedString * attributed = [[NSMutableAttributedString alloc] initWithAttributedString:attributedDetails];
    [attributed addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:10.f] range:[attributed.string rangeOfString:string1]];
    [attributed addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10.f] range:[attributed.string rangeOfString:string2]];
    
    return attributed;
}

- (UIColor*)hex:(NSString*)hex alpha:(float)alpha
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6) return [UIColor grayColor];
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString length] != 6) return  [UIColor grayColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}



-(void)loadPage{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"LogOut",nil)
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(logout)];
    
    NSArray *itemArray = [NSArray arrayWithObjects: NSLocalizedString(@"Ishrana", nil), NSLocalizedString(@"Trening", nil), NSLocalizedString(@"Mere", nil), nil];
    
    self.segmentedControl = [[NYSegmentedControl alloc] initWithItems:itemArray];
    
    // Add desired targets/actions
    [self.segmentedControl addTarget:self action:@selector(segmentSwitch:) forControlEvents:UIControlEventValueChanged];
    
    // Customize and size the control
    self.segmentedControl.titleTextColor = [THEME_MANAGER getBackgroundColor];
    self.segmentedControl.selectedTitleTextColor = [THEME_MANAGER getTextColor];
    self.segmentedControl.segmentIndicatorBackgroundColor = [THEME_MANAGER getAccentColor];
    self.segmentedControl.backgroundColor = [UIColor grayColor];
    self.segmentedControl.borderWidth = 0.0f;
    self.segmentedControl.segmentIndicatorBorderWidth = 0.0f;
    self.segmentedControl.segmentIndicatorInset = 2.0f;
    self.segmentedControl.segmentIndicatorBorderColor = self.view.backgroundColor;
    self.segmentedControl.cornerRadius = self.segmentedControl.intrinsicContentSize.height / 2.0f;
    self.segmentedControl.usesSpringAnimations = YES;
    self.segmentedControl.selectedSegmentIndex=0;
    // Add the control to your view
    self.navigationItem.titleView = self.segmentedControl;
    //[self.view addSubview:segmentedControl];
    
}

-(void)logout{
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:PREF_USER_EMAIL];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:PREF_USER_PASSWORD];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:PREF_USER_LOGIN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.loginVC = [[LoginViewController alloc] init];
    [self.loginVC setTitle:[NSString stringWithFormat:NSLocalizedString(@"log_and_reg",nil)]];
    self.tabBarController.tabBar.hidden = YES;
    
    [self.navigationController pushViewController:self.loginVC animated:YES];
}





//
//    UICollectionViewFlowLayout *layout=  [[UICollectionViewFlowLayout alloc]init];
//    listCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kMarginDefault/2, self.view.frame.size.width, self.view.frame.size.height - kMarginDefault/2) collectionViewLayout:layout];
//    listCollectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    //gatewayCollectionView.delegate = self;
//    //gatewayCollectionView.dataSource = self;
//    listCollectionView.alwaysBounceVertical = YES;
//    listCollectionView.backgroundColor = [THEME_MANAGER getBackgroundColor];
//    listCollectionView.scrollEnabled = NO;
//
//    [self.view addSubview:listCollectionView];
//
//
//    firstNameTextField = [[UIFloatLabelTextField alloc]initWithFrame:CGRectMake(10, 50, 150, 50)];
//    //firstNameTextField.frame = CGRectMake(100, 400, 400, 399);
//    //[firstNameTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
//    firstNameTextField.floatLabelActiveColor = [UIColor orangeColor];
//    firstNameTextField.placeholder = @"Test";
//    firstNameTextField.text = @"Test";
//    firstNameTextField.backgroundColor = [UIColor whiteColor];
//    //firstNameTextField.layer.cornerRadius=8.0f;
//    firstNameTextField.layer.masksToBounds=YES;
//    firstNameTextField.layer.borderColor=[[UIColor redColor]CGColor];
//    firstNameTextField.layer.borderWidth= 1.0f;
//    //firstNameTextField.layer.cornerRadius = 7;
//    firstNameTextField.delegate = self;
//    //[firstNameTextField addTarget:self action:@selector(addLeftIcon) forControlEvents:UIControlEventAllEvents];
//    [listCollectionView addSubview:firstNameTextField];
//
//    UIFloatLabelTextField *filed2 = [UIFloatLabelTextField new];
//    filed2.frame = CGRectMake(CGRectGetMaxX(firstNameTextField.frame)+1, 50, 150, 50);
//    //[filed2 setTranslatesAutoresizingMaskIntoConstraints:NO];
//    filed2.floatLabelActiveColor = [UIColor orangeColor];
//    filed2.backgroundColor = [UIColor whiteColor];
//    filed2.placeholder = @"First Name";
//    filed2.text = @"Arthur";
//    //filed2.layer.cornerRadius = 7;
//    filed2.delegate = self;
//
//    [listCollectionView addSubview:filed2];
//
//    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 200, 300, 40)];
//    textField.borderStyle = UITextBorderStyleRoundedRect;
//    textField.font = [UIFont systemFontOfSize:15];
//    textField.placeholder = @"enter text";
//    textField.autocorrectionType = UITextAutocorrectionTypeNo;
//    textField.keyboardType = UIKeyboardTypeDefault;
//    textField.returnKeyType = UIReturnKeyDone;
//    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    textField.delegate = self;
//    //[gatewayCollectionView addSubview:textField];
//
////    datePicker = [[UIDatePicker alloc]init];
////    datePicker.datePickerMode = UIDatePickerModeTime;
////
////    NSDate *currentDate = [NSDate date];
////    if(datePicker.datePickerMode == UIDatePickerModeTime){
////        currentDate = [[MTSupport getTriggerDateFormater]dateFromString:firstNameTextField.text];
////    }else{
////        currentDate = [[MTSupport getTriggerTimeFormater]dateFromString:firstNameTextField.text];
////    }
////    if(currentDate){ //if currentDate == nil this crash app
////        [datePicker setDate:currentDate];
////    }
////    [listCollectionView addSubview:datePicker];
//
////    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(firstNameTextField.frame)+50, self.view.frame.size.width,150)];
////    datePicker.datePickerMode = UIDatePickerModeTime;
////    datePicker.tintColor = [UIColor whiteColor];
//
//    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(firstNameTextField.frame)+50, self.view.frame.size.width,150)];
//    datePicker.datePickerMode = UIDatePickerModeDate;
//    datePicker.date = [NSDate date];
//    [datePicker setMinimumDate:[NSDate date]];
//
//
//    UIToolbar *toolbar =[[UIToolbar alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(segmentedControl.frame), self.view.frame.size.width,38)];
//    toolbar.barStyle =UIBarStyleDefault;
//    toolbar.tintColor = [THEME_MANAGER getFooterColor];
//
//    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
//                                                                                 target:self
//                                                                                 action:@selector(cancelButtonPressed:)];
//
//    UIBarButtonItem *flexibleSpace =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
//                                                                                 target:self
//                                                                                 action:nil];
//
//    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
//                                                                               target:self
//                                                                               action:@selector(doneButtonPressed:)];
//
//    [toolbar setItems:@[cancelButton,flexibleSpace, doneButton]];
//
//    //self.birthdayDate.inputView = datePicker;
//    //self.birthdayDate.inputAccessoryView = toolbar;
//    [listCollectionView addSubview:datePicker];
//    [listCollectionView addSubview:toolbar];
//
//}
//
//
//- (void)cancelButtonPressed:(id)sender
//{
//    NSDate *currentDate = [NSDate date];
//    currentDate = [[MTSupport getTriggerDateFormater]dateFromString:firstNameTextField.text];
//    [datePicker setMinimumDate:[NSDate date]];
//    [datePicker setDate:currentDate];
//}
//
//- (void)doneButtonPressed:(id)sender
//{
//    NSDate *today = [NSDate date];
//    NSDateFormatter *df = [[NSDateFormatter alloc] init];
//    [df setDateFormat:@"dd.MM.yyyy"];
//    NSString *dateString = [df stringFromDate:today];
//    dateString = [NSString stringWithFormat:@"%@",[df stringFromDate:datePicker.date]];
//    firstNameTextField.text = dateString;
//
//}
//
//-(void)showPickerVC:(UIDatePickerMode)pickerMode{
////    UIViewController *controller = [[UIViewController alloc]init];
////    datePicker = [[UIDatePicker alloc]init];
////    datePicker.datePickerMode = pickerMode;
////    NSDate *currentDate = [NSDate date];
////    if(pickerMode == UIDatePickerModeDate){
////        currentDate = [[MTSupport getTriggerDateFormater]dateFromString:firstNameTextField.text];
////    }else{
////        currentDate = [[MTSupport getTriggerTimeFormater]dateFromString:firstNameTextField.text];
////    }
////    if(currentDate){ //if currentDate == nil this crash app
////        [datePicker setDate:currentDate];
////    }
////    controller.preferredContentSize = CGSizeMake(kDatePickerWidthIPad, kDatePickerHeightIPad);
////    [controller.view addSubview:datePicker];
////    datePopover = [[UIPopoverController alloc]initWithContentViewController:controller];
////    datePopover.delegate = self;
////    if(UIDatePickerModeTime == UIDatePickerModeDate){
////        [datePicker setMinimumDate:[NSDate date]];
////        //[datePopover presentPopoverFromRect:_dateButton.frame inView:_containerView permittedArrowDirections:UIPopoverArrowDirectionUp animated:NO];
////    }else{
////       // [datePopover presentPopoverFromRect:_timeButton.frame inView:_containerView permittedArrowDirections:UIPopoverArrowDirectionUp animated:NO];
////    }
//}
//
//
//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    NSString *title = @"sample title";
//    NSAttributedString *attString =
//    [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//
//    return attString;
//}


@end
