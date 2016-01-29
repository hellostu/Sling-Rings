//
//  AppDelegate.m
//  Sling Rings
//
//  Created by Stuart Lynch on 26/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "AppDelegate.h"
#import "SRViewController.h"

@interface AppDelegate ()
@property(strong, nonatomic) UIViewController *viewController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = [[SRViewController alloc] init];
    return YES;
}

@end
