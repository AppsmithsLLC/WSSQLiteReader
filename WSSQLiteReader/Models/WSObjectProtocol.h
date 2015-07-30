//
//  WSObjectProtocol.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/30/15.
//

#import <Foundation/Foundation.h>

@class FMResultSet;

@protocol WSObjectProtocol <NSObject>

-(instancetype)initWithResultSet:(FMResultSet*)resultSet;

@end
