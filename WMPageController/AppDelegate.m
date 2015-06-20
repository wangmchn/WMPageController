//
//  AppDelegate.m
//  WMPageController
//
//  Created by Mark on 15/6/11.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "AppDelegate.h"
#import "WMPageController.h"
#import "WMTableViewController.h"
#import "WMViewController.h"
#import "WMCollectionViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        Class vcClass;
        NSString *title;
        switch (i%3) {
            case 0:
                vcClass = [WMTableViewController class];
                title = @"Greetings";
                break;
            case 1:
                vcClass = [WMViewController class];
                title = @"Hit Me";
                break;
            default:
                vcClass = [WMCollectionViewController class];
                title = @"Fluency";
                break;
        }
        [viewControllers addObject:vcClass];
        [titles addObject:title];
    }
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    pageVC.title = @"Test";
    pageVC.menuItemWidth = 80;
    pageVC.titleSizeSelected = 15;
    pageVC.pageAnimatable = YES;
//    pageVC.itemsWidths = @[@(150),@(100),@(80),@(90),@(180),@(150),@(100),@(80),@(90),@(180)];
    pageVC.menuViewStyle = WMMenuViewStyleLine;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:pageVC];
    self.window.rootViewController = nav;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
