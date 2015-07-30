//
//  WSDataObjectDateField.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/27/15.
//

#import "WSDataObjectDateField.h"
#import "WSDataObject.h"

@interface WSDataObjectDateField()

@end

@implementation WSDataObjectDateField

-(instancetype)initDataObjectWithFieldType:(WSFieldType)fieldType
                                  dataType:(WSDataType)dataType
                          andAttributeName:(NSString *)attributeName
                            andObjectValue:(id)objectValue
                              andFieldName:(NSString *)fieldName
{
    self = [super initWithDataType:dataType
                  andAttributeName:attributeName
                      andFieldType:fieldType
                      andFieldName:fieldName];
    if (self) {
        _objectValue = objectValue;
    }
    return self;
}

-(id)getObjectValue
{
    return self.objectValue;
}

-(WSDataType)getDataType
{
    return [super getDataType];
}

-(NSString*)getAttributeName
{
    return [super getAttributeName];
}

@end