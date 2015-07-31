//
//  WSDataObject.h
//  WSDatabaseReader
//
//  Created by William Smith on 7/22/15.
//

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

/**
 I normally wouldn't use this approach, but I just need a string for demonstration purposes.
*/
extern NSString * const WSFieldType_toString[];


@class FMResultSet;
@class WSDataObject;

@interface WSDataObject : NSObject


/**
 I intended to comment every file in this detailed manner....then I realized that one file should 
 hopfully be enough to demonstrate that I understand how to write comments. :)
 */

/**
 Initializes a WSDataObject object.
 @param dataType The SQLite data type for the source data.
 @param attributeName The name of the property data object's value is stored in.
 @param fieldType A WSFieldType value with the resulting data object's field type.
 @param fieldName The column name the data originated from.
 @return The newly initialized WSDataObject object.
 */
-(instancetype)initWithDataType:(WSDataType)dataType
               andAttributeName:(NSString*)attributeName
                   andFieldType:(WSFieldType)fieldType
                   andFieldName:(NSString*)fieldName;


/**
 Initializes a WSDataObject object.
 @param dataType The SQLite data type for the source data.
 @param attributeName The name of the property data object's value is stored in.
 @param fieldType A WSFieldType value with the resulting data object's field type.
 @param fieldName The column name the data originated from.
 @return The newly initialized WSDataObject object.
 @warning Object type must match the dataType.
 @warning NSNumber must be used for numeric and boolean values.
 @warning Must be implemented by inheriting classes.
 
 I decided to define this initializer here so all of the inheriting classes will have access to it.  
 If a caller tries to call this method from the WSDataObject class, an exception will be thrown.
 */
-(instancetype)initDataObjectWithFieldType:(WSFieldType)fieldType
                                  dataType:(WSDataType)dataType
                          andAttributeName:(NSString *)attributeName
                            andObjectValue:(id)objectValue
                              andFieldName:(NSString *)fieldName;

/**
 //Factory initializer
 Initializes an instance of WSDataObject object.
 @param dataType The SQLite data type for the source data.
 @param attributeName The name of the property data object's value is stored in.
 @param resultSet The FMResultSet cotaining the data this object will be created from.
 @param fieldName The column name the data originated from.
 @return The newly initialized WSDataObject inherited class object specific to the passed data type.
 */
+(instancetype)createDataObjectWithDataType:(WSDataType)dataType
                           andAttributeName:(NSString*)attributeName
                              withResultSet:(FMResultSet*)resultSet
                               andFieldName:(NSString*)fieldName;




/**
 Returns the value of the object.
 @warning Must be implemented by inheriting classes.
 
 I decided to implement the objectValue property on the inherited classes because it
 needs to be of a specific type for each inherited class.  By placing the getter method declaration
 in the base class, my caller can remain agnostic about the specific type of objet it is working with.
*/
-(id)getObjectValue;


/**
 Returns the value of the data type of the object.
 */
-(WSDataType)getDataType;


/**
 Returns the field name of the object.
 */
-(NSString*)getFieldName;


/**
 Returns the attribute name of the object.
 */
-(NSString*)getAttributeName;


@end
