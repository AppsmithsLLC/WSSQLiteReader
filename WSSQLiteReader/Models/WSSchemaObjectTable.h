//
//  WSSchemaObjectTable.h
//  WSDatabaseReader
//
//  Created by William Smith on 7/22/15.
//

#import "WSSchemaObject.h"

@interface WSSchemaObjectTable : WSSchemaObject

//A collection of WSColumn objects.
//
@property (nonatomic) NSArray* columns;

//A collection of WSRow objects.
//
@property (nonatomic) NSArray* rows;

@end
