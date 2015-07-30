//
//  WSAppSettings.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/25/15.
//

#import "WSAppSettings.h"

@implementation WSAppSettings

#pragma mark - Singleton
+(WSAppSettings*)sharedSettings
{
    static WSAppSettings* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WSAppSettings alloc] init];
    });
    
    return sharedInstance;
}

@end
