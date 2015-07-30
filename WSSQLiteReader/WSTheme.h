//
//  WSTheme.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/25/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WSTheme : NSObject

- (void)applyAppearance;

- (void)styleNavigationController:(UINavigationController *)navigationController;
- (void)styleTableViewCell:(UITableViewCell *)cell;

@property (nonatomic,readonly) UIStatusBarStyle statusBarStyle;
@property (nonatomic,readonly) UIBarStyle barStyle;
@property (nonatomic,readonly) BOOL isDarkColorScheme;
@property (nonatomic) BOOL isDarkBackground;

// Images
//
@property (nonatomic,readonly) UIImage *backgroundImage;

// Main tint colors
//
@property (nonatomic,readonly) UIColor* tintColor;
@property (nonatomic,readonly) UIColor* alternateTintColor;
@property (nonatomic,readonly) UIColor* selectedStateTintColor;
@property (nonatomic,readonly) UIColor* backgroundColor;

// Button Colors
//
@property (nonatomic,readonly) UIColor* buttonTintColor;
@property (nonatomic,readonly) UIColor* buttonTextColor;
@property (nonatomic,readonly) UIColor* alternateButtonTintColor;
@property (nonatomic,readonly) UIColor* cellButtonTextColor;

// Text Colors
//
@property (nonatomic,readonly) UIColor* textColor;
@property (nonatomic,readonly) UIColor* lightTextColor;
@property (nonatomic,readonly) UIColor* placeholderTextColor;
@property (nonatomic,readonly) UIColor* normalSegmentTextColor;

// Table Views Colors
//
@property (nonatomic,readonly) UIColor* tableHeaderColor;
@property (nonatomic,readonly) UIColor* darkTableHeaderColor;
@property (nonatomic,readonly) UIColor* tableHeaderTextColor;

// Nav Bars
//
@property (nonatomic,readonly) BOOL tintNavigationBar;
@property (nonatomic,readonly) UIColor* navBarTextColor;
@property (nonatomic,readonly) UIColor* navBarBackgroundColor;

// Fonts
//
@property (nonatomic,readonly) UIFont* largeFont;
@property (nonatomic,readonly) UIFont* normalFont;
@property (nonatomic,readonly) UIFont* smallFont;
@property (nonatomic,readonly) UIFont* menuFont;
@property (nonatomic,readonly) UIFont* tableViewCellTitleFont;
@property (nonatomic,readonly) UIFont* tableViewCellDetailsFont;

// Misc. Controls
//
@property (nonatomic,readonly) UIColor *progressViewTintColor;

@end
