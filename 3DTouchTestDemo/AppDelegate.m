//
//  AppDelegate.m
//  3DTouchTestDemo
//
//  Created by 杭州任性贸易有限公司 on 2017/8/25.
//  Copyright © 2017年 杭州任性贸易有限公司. All rights reserved.
//
//  github:https://github.com/ShaoGitHub/3-DTouch_IOS

#import "AppDelegate.h"
#import "ViewController.h"
#import "HallViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    ViewController *vc = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    //动态创建应用图标上的3D touch快捷选项
    [self creatShortcutItem];
    UIApplicationShortcutItem *shortcutItem = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
    if (shortcutItem) {
        //判断设置的快捷选项标签唯一标识，根据不同标识执行不同操作
        if([shortcutItem.type isEqualToString:@"com.test.shengyou"]){
            NSLog(@"新启动APP-- 声优界面");
            HallViewController *sayuView = [[HallViewController alloc] init];
            [[self topViewController].navigationController pushViewController:sayuView animated:YES];
        } else if ([shortcutItem.type isEqualToString:@"com.test.shequ"]) {
            //进入搜索界面
            NSLog(@"新启动APP-- 社区界面");
        }
        return NO;
    }
    
    return YES;
}

//动态创建应用图标上的3D touch快捷选项
- (void)creatShortcutItem
{
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:@"com.test.shequ" localizedTitle:@"社区" localizedSubtitle:@"开启心声,展望全新世界" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeHome] userInfo:@{}];
    
    [UIApplication sharedApplication].shortcutItems = @[item1];
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(nonnull UIApplicationShortcutItem *)shortcutItem completionHandler:(nonnull void (^)(BOOL))completionHandler
{
    NSLog(@"%@",shortcutItem.userInfo);
    if (shortcutItem) {
        //判断设置的快捷选项标签唯一标识，根据不同标识执行不同操作
        if([shortcutItem.type isEqualToString:@"com.xys.shengyou"]){
            NSLog(@"新启动APP-- 声优界面");
            HallViewController *sayuView = [[HallViewController alloc] init];
            [[self topViewController].navigationController pushViewController:sayuView animated:YES];
        } else if ([shortcutItem.type isEqualToString:@"com.xys.shequ"]) {
            //进入搜索界面
            NSLog(@"新启动APP-- 社区界面");
        }
    }
    
    if (completionHandler) {
        completionHandler(YES);
    }
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

/**
 *  获取最上层视图
 */
- (UIViewController*)topViewController
{
    return [self topViewControllerWithRootViewController:self.window.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

@end
