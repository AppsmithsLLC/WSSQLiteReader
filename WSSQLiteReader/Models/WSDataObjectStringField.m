//
//  WSDataObjectStringField.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/27/15.
//

#import "WSDataObjectStringField.h"
#import "WSDataObject.h"

@interface WSDataObjectStringField()

@end

@implementation WSDataObjectStringField

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
        _objectValue = (NSString*)objectValue;
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
