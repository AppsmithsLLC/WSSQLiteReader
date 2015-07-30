//
//  WSSchemaObjectColumn.h
//  WSDatabaseReader
//
//  Created by William Smith on 7/22/15.
//

#import "WSSchemaObject.h"
#import "WSDataObject.h"

@class WSSchemaObjectTable;

@interface WSSchemaObjectColumn : WSSchemaObject <WSSchemaObjectProtocol>

@property (nonatomic, readonly, weak) WSSchemaObjectTable *parentTable;

@property (nonatomic) int columnId;
@property (nonatomic) WSDataType dataType;
@property (nonatomic) BOOL notnull;
@property (nonatomic) id defaultValue;
@property (nonatomic) BOOL primaryKey;

@end
