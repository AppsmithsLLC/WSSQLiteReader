//
//  WSSchemaObject.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import "WSSchemaObject.h"
#import "WSSchemaObjectRow.h"
#import "WSSchemaObjectColumn.h"
#import "WSSchemaObjectTable.h"

@interface WSSchemaObject()

@property (nonatomic, readonly) WSSchemaObjectType schemaType;

@end

@implementation WSSchemaObject

-(instancetype)initWithSchemaType:(WSSchemaObjectType)schemaType
                    andObjectName:(NSString *)objectName
{
    self = [super init];
    if (self)
    {
        _schemaType = schemaType;
        _objectName = objectName;
    }
    return self;
}

+(instancetype)initWithObjectType:(WSSchemaObjectType)objectType
                    andObjectName:(NSString*)objectName
                   andParentTable:(WSSchemaObjectTable*)table;
{
    WSSchemaObject* schemaObject = nil;
    
    switch (objectType)
    {
        case WSSchemaObjectTypeRow:
        {
            schemaObject = [[WSSchemaObjectRow alloc] initWithObjectType:objectType andObjectName:objectName andParentTable:table];
            break;
        }
        case WSSchemaObjectTypeColumn:
        {
            schemaObject = [[WSSchemaObjectColumn alloc] initWithObjectType:objectType andObjectName:objectName andParentTable:table];
            break;
        }
        case WSSchemaObjectTypeTable:
        {
            schemaObject = [[WSSchemaObjectTable alloc] initWithObjectType:objectType andObjectName:objectName andParentTable:nil];
            break;
        }
    }
    
    return schemaObject;
}

-(WSSchemaObjectType)getSchemaType
{
    return _schemaType;
}

#pragma mark - Methods for inheriting classes

//Object value must match the dataType.
//NSNumber for numeric and boolean values.
//
-(instancetype)initWithObjectType:(WSSchemaObjectType)objectType
                    andObjectName:(NSString*)objectName
                   andParentTable:(WSSchemaObjectTable*)table
{
    //Must be implemented by inheriting classes.
    //
    NSAssert(NO,@"Must be implemented by inheriting classes.");
    return nil;
}

@end
