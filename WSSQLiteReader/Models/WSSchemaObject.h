//
//  WSSchemaObject.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import "JSONModel.h"

typedef enum {
    WSSchemaObjectTypeColumn,
    WSSchemaObjectTypeRow,
    WSSchemaObjectTypeTable
} WSSchemaObjectType;

//I normally wouldn't use this approach, but I just need the string for demonstration purposes.
//
extern NSString * const WSSchemaObjectType_toString[];

@class WSSchemaObject;
@class WSSchemaObjectTable;

//I am using a protocol here so I can keep my callers agnostic about what type of object is being used.
//This is necessary because currently one object returns a custom value for the objectName property.
//
@protocol WSSchemaObjectProtocol <NSObject>

-(NSString*)getObjectName;

@end

@interface WSSchemaObject : NSObject

@property (nonatomic) NSString* objectName;

//Default initializer
//
-(instancetype)initWithSchemaType:(WSSchemaObjectType)schemaType
                    andObjectName:(NSString *)objectName;

//Factory method that returns a derived class object.
//
+(instancetype)initWithObjectType:(WSSchemaObjectType)objectType
                    andObjectName:(NSString*)objectName
                   andParentTable:(WSSchemaObjectTable*)table;

//Object value must match the dataType.
//NSNumber for numeric and boolean values.
//
-(instancetype)initWithObjectType:(WSSchemaObjectType)objectType
                    andObjectName:(NSString*)objectName
                   andParentTable:(WSSchemaObjectTable*)table;


-(WSSchemaObjectType)getSchemaType;


@end
