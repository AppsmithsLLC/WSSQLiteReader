//
//  WSSchemaObject.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import <Foundation/Foundation.h>

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

@interface WSSchemaObject : NSObject

@property (nonatomic) NSString* objectName;

//Default initializer
//
-(instancetype)initWithSchemaType:(WSSchemaObjectType)schemaType
                    andObjectName:(NSString *)objectName;

//Object value must match the dataType.
//NSNumber for numeric and boolean values.
//
-(instancetype)initWithObjectType:(WSSchemaObjectType)objectType
                    andObjectName:(NSString*)objectName
                   andParentTable:(WSSchemaObjectTable*)table;

//Factory method that returns a derived class object.
//
+(instancetype)initWithObjectType:(WSSchemaObjectType)objectType
                    andObjectName:(NSString*)objectName
                   andParentTable:(WSSchemaObjectTable*)table;


-(WSSchemaObjectType)getSchemaType;

-(NSString*)getObjectName;

@end
