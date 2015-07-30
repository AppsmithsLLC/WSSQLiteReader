//
//  WSDataObject.m
//  WSDatabaseReader
//
//  Created by William Smith on 7/22/15.
//

#import "WSDataObject.h"
#import "FMResultSet.h"
#import "WSDataObjectStringField.h"
#import "WSDataObjectNumberField.h"
#import "WSDataObjectDateField.h"
#import "WSDataObjectBoolField.h"

@interface WSDataObject()

@property (nonatomic) WSDataType dataType;
@property (nonatomic) NSString *attributeName;
@property (nonatomic, readonly) WSFieldType fieldType;
@property (nonatomic) NSString* fieldName;

@end

@implementation WSDataObject

+(instancetype)createDataObjectWithDataType:(WSDataType)dataType
                           andAttributeName:(NSString *)attributeName
                              withResultSet:(FMResultSet*)resultSet
                               andFieldName:(NSString *)fieldName
{
    WSDataObject *dataObject = nil;
    
    switch (dataType) {
        case WSDataTypeText:
        case WSDataTypeUUIDText:
        {
            NSString *value = [resultSet stringForColumn:attributeName];
            dataObject = [[WSDataObjectStringField alloc] initDataObjectWithFieldType:WSFieldTypeStringField
                                                                             dataType:dataType
                                                                     andAttributeName:NSStringFromSelector(@selector(objectValue))
                                                                       andObjectValue:value
                                                                         andFieldName:fieldName];
            break;
        }
        case WSDataTypeInteger:
        case WSDataTypeInt16:
        case WSDataTypeInt32:
        {
            NSNumber *value = [NSNumber numberWithInteger:[resultSet intForColumn:attributeName]];
            dataObject = [[WSDataObjectNumberField alloc] initDataObjectWithFieldType:WSFieldTypeNumberField
                                                                             dataType:dataType
                                                                     andAttributeName:NSStringFromSelector(@selector(objectValue))
                                                                       andObjectValue:value
                                                                         andFieldName:fieldName];
            break;
        }
        case WSDataTypeLongLong:
        {
            NSNumber *value = [NSNumber numberWithLongLong:[resultSet longLongIntForColumn:attributeName]];
            dataObject = [[WSDataObjectNumberField alloc] initDataObjectWithFieldType:WSFieldTypeNumberField
                                                                             dataType:dataType
                                                                     andAttributeName:NSStringFromSelector(@selector(objectValue))
                                                                       andObjectValue:value
                                                                         andFieldName:fieldName];
            break;
        }
        case WSDataTypeFloat64:
        {
            NSNumber *value = [NSNumber numberWithDouble:[resultSet doubleForColumn:attributeName]];
            dataObject = [[WSDataObjectNumberField alloc] initDataObjectWithFieldType:WSFieldTypeNumberField
                                                                             dataType:dataType
                                                                     andAttributeName:NSStringFromSelector(@selector(objectValue))
                                                                       andObjectValue:value
                                                                         andFieldName:fieldName];
            break;
        }
        case WSDataTypeRealDate:
        {
            NSDate *value = [resultSet dateForColumn:attributeName];
            dataObject = [[WSDataObjectDateField alloc] initDataObjectWithFieldType:WSFieldTypeDateField
                                                                           dataType:dataType
                                                                   andAttributeName:NSStringFromSelector(@selector(objectValue))
                                                                     andObjectValue:value
                                                                       andFieldName:fieldName];
            break;
        }
        case WSDataTypeBoolean:
        {
            NSNumber *value = [NSNumber numberWithBool:[resultSet boolForColumn:attributeName]];
            dataObject = [[WSDataObjectBoolField alloc] initDataObjectWithFieldType:WSFieldTypeBoolField
                                                                           dataType:dataType
                                                                   andAttributeName:NSStringFromSelector(@selector(objectValue))
                                                                     andObjectValue:value
                                                                       andFieldName:fieldName];
            break;
        }
    }
    
    return dataObject;
}


-(instancetype)initWithDataType:(WSDataType)dataType
               andAttributeName:(NSString*)attributeName
                   andFieldType:(WSFieldType)fieldType
                   andFieldName:(NSString*)fieldName
{
    self = [super init];
    if (self)
    {
        _dataType = dataType;
        _attributeName = attributeName;
        _fieldType = fieldType;
        _fieldName = fieldName;
    }
    
    return self;
}

-(WSDataType)getDataType
{
    return _dataType;
}

-(NSString*)getAttributeName
{
    return _attributeName;
}

-(NSString*)getFieldName
{
    return self.fieldName;
}

#pragma mark - Methods for inheriting classes
-(instancetype)initDataObjectWithFieldType:(WSFieldType)fieldType
                                  dataType:(WSDataType)dataType
                          andAttributeName:(NSString *)attributeName
                            andObjectValue:(id)objectValue
                              andFieldName:(NSString *)fieldName
{
    NSAssert(NO,@"Must be implemented by inheriting classes.");
    return nil;
}

-(id)getObjectValue
{
    NSAssert(NO,@"Must be implemented by inheriting classes.");
    return nil;
}
@end
