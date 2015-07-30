//
//  WSSchemaObjectColumn.m
//  WSDatabaseReader
//
//  Created by William Smith on 7/22/15.
//

#import "WSSchemaObjectColumn.h"

@interface WSSchemaObjectColumn() 

@end

@implementation WSSchemaObjectColumn


-(instancetype)initWithObjectType:(WSSchemaObjectType)objectType
                    andObjectName:(NSString*)objectName
                   andParentTable:(WSSchemaObjectTable*)table
{
    self = [super initWithSchemaType:objectType
                       andObjectName:objectName];
    if (self)
    {
        _parentTable = table;
    }
    return self;
}


#pragma mark WSDataObjectProtocol
-(NSString*)getObjectName
{
    //Returns column name.
    //
    return self.objectName;
}

-(WSSchemaObjectType)getObjectType
{
    return WSSchemaObjectTypeColumn;
}

@end
