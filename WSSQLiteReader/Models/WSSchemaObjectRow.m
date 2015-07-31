//
//  WSSchemaObjectRow.m
//  WSDatabaseReader
//
//  Created by William Smith on 7/22/15.
//

#import "WSSchemaObjectRow.h"
#import "WSSchemaObjectColumn.h"
#import "WSSchemaObject.h"

#import "WSDataObject.h"

/*  In general, I try to hide as much information about my classes as possible.
    This includes defining properties in the implementation file when at all possible.
    If my class adheres to a protocol simply to act as a delegate for another class, 
        I will also define the protocol adherance in the implementation file as well.
 */
@interface WSSchemaObjectRow()

@property (nonatomic) NSString* rowObjectName;

@end

@implementation WSSchemaObjectRow


-(instancetype)initWithObjectType:(WSSchemaObjectType)objectType
                    andObjectName:(NSString*)objectName
                   andParentTable:(WSSchemaObjectTable*)table;
{
    self = [super initWithSchemaType:objectType
                       andObjectName:objectName];
    if (self)
    {
        _parentTable = table;
        _fields = [NSMutableDictionary dictionary];
    }
    return self;
}

-(NSString*)getObjectName
{
    if (!self.rowObjectName || [self.rowObjectName length] == 0)
    {
        NSString *columnName = [self.orderColumn getObjectName];
        WSDataObject *data = [self.fields objectForKey:columnName];
        self.rowObjectName = [NSString stringWithFormat:@"%@: %@", columnName, [data getObjectValue]];
    }
    
    return self.rowObjectName;  
}

@end
