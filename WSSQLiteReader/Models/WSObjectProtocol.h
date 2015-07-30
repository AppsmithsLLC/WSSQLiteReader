//
//  WSObjectProtocol.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/30/15.
//

#import <Foundation/Foundation.h>

@class FMResultSet;

@protocol WSObjectProtocol <NSObject>

/*
    I created this protocol that all of the data objects will adhere to.
    Since I am using FMDatabase for all of my SQLite access, I decided to have a "generic" initializer
    that recieves a FMResultSet and builds the model object from that.
 */

-(instancetype)initWithResultSet:(FMResultSet*)resultSet;

@end
