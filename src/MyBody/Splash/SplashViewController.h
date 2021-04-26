//
//  SplashViewController.h
//  MyBody
//
//  Created by Milovan Tomasevic on 29/10/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface SplashViewController : UIViewController<UITabBarControllerDelegate> 

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabController;
@property (strong, nonatomic) LoginViewController *loginVC;



-(void)doLogin;
-(void)doLogout;
-(void)goMenu;

@end

