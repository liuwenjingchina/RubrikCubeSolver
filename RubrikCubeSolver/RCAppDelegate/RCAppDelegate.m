//
//  RCAppDelegate.m
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import "RCAppDelegate.h"
#import "RCViewController.h"
@implementation RCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // alloc window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    // alloc View Controller
    UIDevice *currentDevice = [UIDevice currentDevice];
    switch ([currentDevice userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPhone:
            self.viewController = [[RCViewController alloc] initWithNibName:@"RCViewController_iPhone" bundle:nil];
            break;
        case UIUserInterfaceIdiomPad:
            self.viewController = [[RCViewController alloc] initWithNibName:@"RCViewController_iPad" bundle:nil];
            break;
        default:
            RCAssert(0,@"Device Not Supported");
            break;
    }

    // init
    [self.window setRootViewController:self.viewController];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
