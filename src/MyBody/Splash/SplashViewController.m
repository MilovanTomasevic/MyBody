//
//  SplashViewController.m
//  MyBody
//
//  Created by Milovan Tomasevic on 29/10/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "SplashViewController.h"
#import "HomeViewController.h"
#import "TreningViewController.h"
#import "IshranaViewController.h"
#import "MereViewController.h"
#import "AppDelegate.h"

static const CGFloat kImageHeight = 49;

@interface SplashViewController (){
    UIImageView *imgSplash;
    UIActivityIndicatorView *activityIndicator;
    UILabel *labText;
    AppDelegate *appDelegate;
}

@end

@implementation SplashViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.view.userInteractionEnabled = YES;
    imgSplash = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    imgSplash.image = [UIImage imageNamed:@"splashPic"];
    
    labText = [[UILabel alloc ]initWithFrame:CGRectMake(kMarginDefault, imgSplash.frame.size.height-5*kMarginDefault, imgSplash.frame.size.width-2*kMarginDefault, kUILabelDefHeight)];
    labText.text = NSLocalizedString(@"welcome_message", nil);
    
    labText.font = [THEME_MANAGER fontWithStyleName:OCFontStyleLight size:kFontSizeMinimum];
    labText.textColor = [THEME_MANAGER getAccentColor];
    labText.textAlignment = NSTextAlignmentCenter;
    labText.lineBreakMode = NSLineBreakByWordWrapping;
    labText.numberOfLines = 0;
    [imgSplash addSubview:labText];
    
    //Create and add the Activity Indicator to splashView
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityIndicator setColor:[THEME_MANAGER getAccentColor]];
    activityIndicator.center = CGPointMake(imgSplash.frame.size.width/2, imgSplash.frame.size.height-(5*kMarginDefault+kMarginDefault));
    [imgSplash addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    [imgSplash setAlpha:1];
    [self.view addSubview:imgSplash];
    [self.view bringSubviewToFront:imgSplash];
    self.view.userInteractionEnabled = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    [self performSelector:@selector(hideSplash) withObject:nil afterDelay:3];
}

-(void)hideSplash{

    if([[NSUserDefaults standardUserDefaults] boolForKey:PREF_USER_LOGIN]) {
        [self goMenu];
    }else{
        [self doLogin];
    }
}

-(void)doLogin{
        self.loginVC = [[LoginViewController alloc] init];
        [self.loginVC setTitle:[NSString stringWithFormat:NSLocalizedString(@"log_and_reg",nil)]];
        [self.navigationController pushViewController:self.loginVC animated:YES];
}

-(void)doLogout{
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:PREF_USER_EMAIL];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:PREF_USER_PASSWORD];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:PREF_USER_LOGIN];
    [[NSUserDefaults standardUserDefaults] synchronize];

    self.loginVC = [[LoginViewController alloc] init];
    [self.loginVC setTitle:[NSString stringWithFormat:NSLocalizedString(@"log_and_reg",nil)]];
    
    [self.navigationController pushViewController:self.loginVC animated:YES];
}

-(void)goMenu{
    self.tabController = [UITabBarController new];
    
    HomeViewController *con4 = [[HomeViewController alloc] init];
    
    UINavigationController *nCon4 = [[UINavigationController alloc]initWithRootViewController:con4];
    
    TreningViewController *con3 = [[TreningViewController alloc] init];
    UINavigationController *nCon3 = [[UINavigationController alloc]initWithRootViewController:con3];
    
    IshranaViewController *con2 = [[IshranaViewController alloc] init];
    UINavigationController *nCon2 = [[UINavigationController alloc]initWithRootViewController:con2];
    
    MereViewController *con1 = [[MereViewController alloc] init];
    UINavigationController *nCon1 = [[UINavigationController alloc]initWithRootViewController:con1];
    
    self.tabController.viewControllers = @[nCon1, nCon2, nCon3, nCon4];
    
    
    
    UITabBarItem *item4 = self.tabController.tabBar.items[3];
    item4.title = @"Home";
    item4.image = [UIImage imageNamed:@"tab_home"];
    item4.selectedImage = [UIImage imageNamed:@"tab_home_sel"];
    [item4 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont fontWithName:@"Helvetica" size:10.0], NSFontAttributeName,
                                   [UIColor blackColor], NSForegroundColorAttributeName,
                                   nil] forState:UIControlStateNormal];
    
    UITabBarItem *item3 = self.tabController.tabBar.items[2];
    item3.title = @"Trening";
    item3.image = [UIImage imageNamed:@"tab_trening"];
    item3.selectedImage = [UIImage imageNamed:@"tab_trening_sel"];
    [item3 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont fontWithName:@"Helvetica" size:10.0], NSFontAttributeName,
                                   [UIColor blackColor], NSForegroundColorAttributeName,
                                   nil] forState:UIControlStateNormal];
    
    UITabBarItem *item2 = self.tabController.tabBar.items[1];
    item2.title = @"Ishrana";
    item2.image = [UIImage imageNamed:@"tab_ishrana"];
    item2.selectedImage = [UIImage imageNamed:@"tab_ishrana_sel"];
    [item2 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont fontWithName:@"Helvetica" size:10.0], NSFontAttributeName,
                                   [UIColor blackColor], NSForegroundColorAttributeName,
                                   nil] forState:UIControlStateNormal];
    
    UITabBarItem *item1 = self.tabController.tabBar.items[0];
    item1.title = @"Mere";
    item1.image = [UIImage imageNamed:@"tab_mere"];
    item1.selectedImage = [UIImage imageNamed:@"tab_mere_sel"];
    [item1 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont fontWithName:@"Helvetica" size:10.0], NSFontAttributeName,
                                   [UIColor blackColor], NSForegroundColorAttributeName,
                                   nil] forState:UIControlStateNormal];
    
    for(UITabBarItem *item in self.tabController.tabBar.items) {
        item.image = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    //[tabController.tabBar setTabIconWidth:29];
    // [tabController.tabBar setBadgeTop:9];
    
    //    UIImage* tabBarBackground;
    //    tabBarBackground = [self tabImageColor:tabBarBackground];
    //    [[UITabBar appearance] setSelectionIndicatorImage:tabBarBackground];
    

    self.tabController.delegate =self;
    self.tabController.selectedIndex = 3;
    
    appDelegate.window.rootViewController = self.tabController;
}

-(UIImage *)tabImageColor:(UIImage *)img{
    UIImage *image =  [MTSupport imageWithColor:[THEME_MANAGER getAccentColor] andSize:CGSizeMake( self.view.frame.size.width/4,kImageHeight)];
    
    return image;
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
@end
