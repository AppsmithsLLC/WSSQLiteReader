//
//  WSFileHelper.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/26/15.
//

#import <Foundation/Foundation.h>

@interface WSFileHelper : NSObject

/**
 Why do I use a singleton pattern here?
 
 */
+(WSFileHelper*)sharedHelper;

-(NSURL*)applicationCacheDirectory;

-(NSString*)getSQLiteDBPath;

@end
