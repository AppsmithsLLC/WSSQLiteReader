//
//  WSSchemaObjectTable.m
//  WSDatabaseReader
//
//  Created by William Smith on 7/22/15.
//

#import "WSSchemaObjectTable.h"
#import "WSSchemaObject.h"

@interface WSSchemaObjectTable()

@end

@implementation WSSchemaObjectTable

-(instancetype)initWithObjectType:(WSSchemaObjectType)objectType
                    andObjectName:(NSString*)objectName
                   andParentTable:(WSSchemaObjectTable*)table
{
    self = [super initWithSchemaType:objectType andObjectName:objectName];
    if (self)
    {
        
    }
    return self;
}


#pragma mark WSDataObjectProtocol
-(NSString*)getObjectName
{
    //Returns table name.
    //
    return self.objectName;
}

@end
