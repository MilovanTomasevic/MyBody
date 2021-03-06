//
//  AppDelegate.m
//  MyBody
//
//  Created by Milovan Tomasevic on 29/10/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    MTBaseTheme *theme = THEME_MANAGER;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //UINavigationController * navigationController = [UINavigationController alloc];

    self.splashVC = [[SplashViewController alloc] init];
    self.navigationController  = [[UINavigationController alloc] initWithRootViewController:self.splashVC];
    
    
    //(void)[navigationController initWithRootViewController:splashVC];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    // nav bar
    [[UINavigationBar appearance] setTintColor:[theme getAccentColor]];
//    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:@{
//                                                                                                       NSFontAttributeName : [THEME_MANAGER fontWithStyleName:OCFontStyleMedium size:kFontSizeDefIPhone]
//                                                                                                       } forState:UIControlStateNormal];
//    [[MBProgressHUD appearance] setLabelFont:[THEME_MANAGER fontWithStyleName:OCFontStyleMedium size:kFontSizeDefIPhone]];
//    [[MBProgressHUD appearance] setDetailsLabelFont:[THEME_MANAGER fontWithStyleName:OCFontStyleLight size:13]];
//
    //text tint color
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [THEME_MANAGER getTextColor] }
                                             forState:UIControlStateNormal];
    
    //background tint color
    [[UITabBar appearance] setBarTintColor:[THEME_MANAGER getFooterColor]];
    [[UITabBar appearance] setTintColor:[THEME_MANAGER getAccentColor]];

    
    
    [[UINavigationBar appearance] setBarTintColor:[THEME_MANAGER getFooterColor]];
    
    NSMutableDictionary* normalItemAttributes = [NSMutableDictionary dictionaryWithObject:[THEME_MANAGER fontWithStyleName:OCFontStyleRegular size:13.0f] forKey:NSFontAttributeName];
    // selected text color
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [THEME_MANAGER getTextColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    // set color of unselected text
    [normalItemAttributes setValue:[THEME_MANAGER getTextColorWithAlpha:kAlternativeColorAlpha] forKey:NSForegroundColorAttributeName];
    
    [[UITabBarItem appearance] setTitleTextAttributes:normalItemAttributes forState:UIControlStateNormal];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [THEME_MANAGER getAccentColor]}];
     
    
    self.window.backgroundColor = [THEME_MANAGER getBackgroundColor];
    
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self saveContext];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack


- (void)saveContext{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            LogE(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
}

#pragma mark - Core Data Saving support

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MyBody" ofType:@"momd"];
    NSURL *momURL = [NSURL fileURLWithPath:path];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:momURL];
    
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MyBodyDB.sqlite"];
    
    NSError *error = nil;
    
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        LogE(@"Unresolved error %@, %@", error, [error description]);
        [[NSFileManager defaultManager]removeItemAtURL:storeURL error:nil];
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error];
        
    }
    return _persistentStoreCoordinator;
}


#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
