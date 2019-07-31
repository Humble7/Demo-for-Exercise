//
//  AppDelegate.m
//  OCTextKitNotePad
//
//  Created by ChenZhen on 2019/7/31.
//  Copyright © 2019 ChenZhen. All rights reserved.
//

#import "AppDelegate.h"
#import "AppRouter.h"
#import "NotesListViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self p_configNavigationBar];
    
    NotesListViewController *homeVc = [NotesListViewController new];
    [AppRouter.sharedAppRouter showViewController:homeVc];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = AppRouter.sharedAppRouter.rootViewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)p_configNavigationBar {
    UIColor *barColor = [UIColor colorWithRed:0.175 green:0.458 blue:0.831 alpha:1];
    [UINavigationBar appearance].barTintColor = barColor;
    [UINavigationBar appearance].tintColor = UIColor.whiteColor;
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}


@end
