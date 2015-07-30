//
//  AppDelegate.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import "AppDelegate.h"
#import "WSPropertyFormItem.h"
#import "WSFileHelper.h"
#import "WSAppSettings.h"
#import "WSMainForm.h"
#import "WSLightTheme.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self createEditableCopyOfDatabaseIfNeeded];
    
    WSMainForm *rootVC = [[WSMainForm alloc] init];
    
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:rootVC];
    nav.navigationBar.barStyle = [WSAppSettings sharedSettings].theme.barStyle;
    nav.navigationItem.leftBarButtonItem = nil;
    
    self.window.rootViewController = nav;
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    //Set the initial theme on first run.
    //
    if (![[WSAppSettings sharedSettings] theme])
        [[WSAppSettings sharedSettings] setTheme:[[WSLightTheme alloc] init]];
    
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

#pragma mark - Helper methods
// Creates a writable copy of the bundled default database in the application Documents directory.
- (void)createEditableCopyOfDatabaseIfNeeded {
    // First, test for existence.
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsDirectory = [[WSFileHelper sharedHelper] applicationCacheDirectory].path;
    NSString *writableDBPath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, [[NSBundle mainBundle] objectForInfoDictionaryKey:@"dbFileName"]];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success)
        return;
    
    // The writable database does not exist, so copy the default to the appropriate location.
    NSError *error;
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"dbFileName"]];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

@end
