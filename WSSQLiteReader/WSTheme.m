//
//  WSTheme.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/25/15.
//

#import "WSTheme.h"

@implementation WSTheme

- (void)applyAppearance
{
    // Apply navigation bar theme
    //
    UIColor *navBarTextColor;
    if (self.tintNavigationBar)
    {
        [[UINavigationBar appearance] setBarTintColor:self.navBarBackgroundColor];
        [[UINavigationBar appearance] setTintColor:self.navBarTextColor];
        navBarTextColor = self.navBarTextColor;
    }
    else
    {
        [[UINavigationBar appearance] setBarTintColor:nil];
        [[UINavigationBar appearance] setTintColor:self.tintColor];
        navBarTextColor = [UIColor blackColor];
    }
    
    NSDictionary *navbarTitleTextAttributes = @{NSForegroundColorAttributeName: navBarTextColor};
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    
    // Apply status bar theming
    //
    // Note: this probably does nothing. May be able to remove this but
    // not going to until we're clear that the status bar udpates we're performing
    // elsewhere are being done properly.
    //
    // Needs testing.
    //
    [[UIApplication sharedApplication] setStatusBarStyle:self.statusBarStyle];
    
    [[UISegmentedControl appearance] setTintColor:self.tintColor];
    
    [[UIPageControl appearance] setPageIndicatorTintColor:[UIColor lightGrayColor]];
    [[UIPageControl appearance] setCurrentPageIndicatorTintColor:self.tintColor];
}

- (void)styleNavigationController:(UINavigationController *)navigationController
{
    
}

- (void)styleTableViewCell:(UITableViewCell *)cell
{
    
}

@end
