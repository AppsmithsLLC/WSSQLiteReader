//
//  WSLightTheme.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/25/15.
//

#import "WSLightTheme.h"
#import "UIColor+Extension.h"

@implementation WSLightTheme

-(UIStatusBarStyle)statusBarStyle
{
    return self.isDarkBackground ? UIStatusBarStyleLightContent : UIStatusBarStyleDefault;
}

-(UIBarStyle)barStyle
{
    return UIBarStyleDefault;
}

- (BOOL)isDarkColorScheme
{
    return NO;
}

#pragma mark - Images
#pragma mark -

- (UIImage *)backgroundImage
{
    return [UIImage imageNamed:@"green-blurred-background.jpg"];
}

#pragma mark - Main Tint Colors
#pragma mark -

- (UIColor *)tintColor
{
    return [UIColor colorWithRed:.13 green:0.44 blue:0.27 alpha:1];
}

- (UIColor *)alternateTintColor
{
    return [UIColor colorWithRed:1 green:0.45 blue:0.13 alpha:1];
}

- (UIColor *)selectedStateTintColor
{
    UIColor* tintColor = self.tintColor;
    CGFloat h,s,b,a;
    [tintColor getHue:&h saturation:&s brightness:&b alpha:&a];
    CGFloat darker = b - .1;
    if (darker < 0)
        darker = 0;
    CGFloat satursize = s + .3;
    if (satursize > 1)
        satursize = 1;
    return [UIColor colorWithHue:h saturation:satursize brightness:darker alpha:.2];
}

- (UIColor *)backgroundColor
{
    return [UIColor whiteColor];
}

#pragma mark - Button Colors
#pragma mark -

- (UIColor *)buttonTintColor
{
    return [self.tintColor colorWithAlpha:.5];
}

- (UIColor *)buttonTextColor
{
    return [UIColor whiteColor];
}

- (UIColor *)alternateButtonTintColor
{
    return [UIColor whiteColor];
}

- (UIColor *)cellButtonTextColor
{
    return [self.tintColor colorWithSaturation:.46 brightness:.44 alpha:1];
}

#pragma mark - Text Colors
#pragma mark -

- (UIColor *)textColor
{
    return [UIColor blackColor];
}

- (UIColor *)lightTextColor
{
    return [UIColor whiteColor];
}

- (UIColor *)placeholderTextColor
{
    return [UIColor lightGrayColor];
}

- (UIColor *)normalSegmentTextColor
{
    return [UIColor blackColor];
}

#pragma mark - Table View Colors
#pragma mark -

- (UIColor *)tableHeaderColor
{
    return [UIColor colorWithRed:.85 green:.85 blue:.85 alpha:1];
}

- (UIColor *)darkTableHeaderColor
{
    return [self.tintColor colorWithSaturation:.46 brightness:.44 alpha:1];
}

- (UIColor *)tableHeaderTextColor
{
    return [UIColor whiteColor];
}

//#pragma mark - Message Boxes
//#pragma mark -
//
//- (UIColor *)messageBackgroundColor
//{
//    return self.tintColor;
//}
//
//- (UIColor *)messageForegroundColor
//{
//    return [UIColor whiteColor];
//}

#pragma mark - Nav Bar Colors
#pragma mark -

- (BOOL)tintNavigationBar
{
    return NO;
}

- (UIColor *)navBarTextColor
{
    return [self darkTableHeaderColor];
}

- (UIColor *)navBarBackgroundColor
{
    return self.tintColor;
}

- (void)applyNavigationBarAppearance
{
    [[UINavigationBar appearance] setBarTintColor:nil];
    [[UINavigationBar appearance] setTintColor:self.tintColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
}

- (void)applyThemeToNavigationController:(UINavigationController *)navigationController
{
    
}

#pragma mark - Fonts
#pragma mark -

- (UIFont *)largeFont
{
    return [UIFont boldSystemFontOfSize:30];
}

- (UIFont *)normalFont
{
    return [UIFont fontWithName:@"HelveticaNeue-Thin" size:16];
}

- (UIFont *)smallFont
{
    return [UIFont fontWithName:@"HelveticaNeue-Thin" size:12];
}

- (UIFont *)menuFont
{
    return [UIFont fontWithName:@"HelveticaNeue-Thin" size:22];
}

- (UIFont *)tableViewCellTitleFont
{
    return [UIFont systemFontOfSize:18];
}

- (UIFont *)tableViewCellDetailsFont
{
    return [UIFont fontWithName:@"HelveticaNeue-Thin" size:14];
}

#pragma mark - Misc
#pragma mark -

- (UIColor *)progressViewTintColor
{
    return self.tableHeaderColor;
}

@end
