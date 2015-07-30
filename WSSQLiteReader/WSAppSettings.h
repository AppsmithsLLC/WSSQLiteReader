//
//  WSAppSettings.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/25/15.
//

#import <UIKit/UIKit.h>
#import "WSTheme.h"

@interface WSAppSettings : NSObject

#define kColorSchemeSetting @"ColorSchemeSetting"

#define kAppLargeFontSetting @"AppLargeFontSetting"
#define kAppNormalFontSetting @"AppNormalFontSetting"
#define kAppSmallFontSetting @"AppSmallFontSetting"
#define kAppMenuFontSetting @"AppMenuFontSetting"
#define kAppTableViewCellTitleFontSetting @"AppTableViewCellTitleFontSetting"
#define kAppTableViewCellDetailsFontSetting @"AppTableViewCellDetailsFontSetting"
#define kAutoSyncSetting @"AutoSyncSetting"
#define kAutoselectFieldSetting @"AutoselectField"

//Color schemes
#define kColorSchemeLight @"ColorSchemeLight"

#define kHeightForHeaderInSectionShort 20
#define kHeightForHeaderInSectionNormal 40
#define kHeightForSlimRow 40
#define kHeightForStandardRow 55
#define kHeightForTextViewRow 100

+(WSAppSettings*)sharedSettings;


#pragma mark - Application Color/Font theme
#pragma mark -

// The applications active color theme
//
@property (nonatomic) WSTheme *theme;

// Forces the app to reset it's colors to the active color scheme
//
- (void)refreshTheme;


@end
