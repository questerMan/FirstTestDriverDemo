//
//  AppDelegate.m
//  LiXinDriverTest
//
//  Created by lixin on 16/11/6.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [AMapServices sharedServices].apiKey = AMMAP_KEY;

    [self initWindow];
    
    return YES;
}
/** 初始化window */
-(void)initWindow{
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    MainVC *mainVC = [[MainVC alloc]init];
    
    UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:mainVC];
    
    LeftVC *leftViewController = [[LeftVC alloc] init];
    
//    UINavigationController *nac2 = [[UINavigationController alloc] initWithRootViewController:leftViewController];
//    nac2.navigationBarHidden = YES;
    
    SlideMenuController *slideMenuController = [[SlideMenuController alloc] initWithMainViewController:nac leftMenuViewController:leftViewController];
    
    slideMenuController.automaticallyAdjustsScrollViewInsets = YES;
    
    [slideMenuController changeLeftViewWidth:MATCHSIZE(550)];
    
    slideMenuController.delegate = mainVC;
    
    self.window.rootViewController = slideMenuController;
    
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
