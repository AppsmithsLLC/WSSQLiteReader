//
//  WSDataObject.h
//  WSDatabaseReader
//
//  Created by William Smith on 7/22/15.
//

#import "JSONModel.h"
#import "WSSchemaObject.h"


typedef enum {
    WSDataTypeInteger,
    WSDataTypeInt16,
    WSDataTypeInt32,
    WSDataTypeFloat64,
    WSDataTypeLongLong,
    WSDataTypeText,
    WSDataTypeUUIDText,
    WSDataTypeRealDate,
    WSDataTypeBoolean
} WSDataType;

typedef enum {
    WSFieldTypeStringField,
    WSFieldTypeNumberField,
    WSFieldTypeDateField,
    WSFieldTypeBoolField
} WSFieldType;

//I normally wouldn't use this approach, but I just need the string for demonstration purposes.
//
extern NSString * const WSFieldType_toString[];


@class FMResultSet;
@class WSDataObject;

@interface WSDataObject : NSObject


//Default initializer
//
-(instancetype)initWithDataType:(WSDataType)dataType
               andAttributeName:(NSString*)attributeName
                   andFieldType:(WSFieldType)fieldType
                   andFieldName:(NSString*)fieldName;

//Object value must match the dataType.
//NSNumber for numeric and boolean values.
//
-(instancetype)initDataObjectWithFieldType:(WSFieldType)fieldType
                                  dataType:(WSDataType)dataType
                            andObjectValue:(id)objectValue
                              andFieldName:(NSString*)fieldName;

//Factory initilizer
//
+(instancetype)createDataObjectWithDataType:(WSDataType)dataType
                           andAttributeName:(NSString*)attributeName
                              withResultSet:(FMResultSet*)resultSet
                               andFieldName:(NSString*)fieldName;


//Returns the value of the object.
//
-(id)getObjectValue;
-(WSDataType)getDataType;
-(NSString*)getFieldName;
-(NSString*)getAttributeName;


@end
