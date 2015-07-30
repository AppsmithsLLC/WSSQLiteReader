//
//  WSDataObjectBoolField.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/27/15.
//

#import "WSDataObjectBoolField.h"
#import "WSDataObject.h"

@interface WSDataObjectBoolField()

@end

@implementation WSDataObjectBoolField

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
        _objectValue = [objectValue boolValue];
    }
    return self;
}

-(id)getObjectValue
{
    return [NSNumber numberWithBool:self.objectValue];
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
