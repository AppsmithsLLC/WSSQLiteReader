//
//  WSFileHelper.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/26/15.
//

#import "WSFileHelper.h"
#import "WSAppSettings.h"

@implementation WSFileHelper

#pragma mark - Singleton
+(WSFileHelper*)sharedHelper
{
    static WSFileHelper* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WSFileHelper alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - Public Methods
-(NSURL*)applicationCacheDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory
                                            inDomains:NSUserDomainMask] lastObject];
}

/**
 Why use plist?
 */
- (NSString*)getSQLiteDBPath
{
    NSString* cachePath = [self applicationCacheDirectory].path;
    NSString* filePath = [NSString stringWithFormat:@"%@/%@", cachePath, [[NSBundle mainBundle] objectForInfoDictionaryKey:@"dbFileName"]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        return filePath;
    }
    
    return nil;
}

@end
