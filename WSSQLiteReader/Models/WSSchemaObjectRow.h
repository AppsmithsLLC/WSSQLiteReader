//
//  WSSchemaObjectRow.h
//  WSDatabaseReader
//
//  Created by William Smith on 7/22/15.
//

#import "WSDataObject.h"

@class WSSchemaObjectColumn;
@class WSSchemaObjectTable;

@interface WSSchemaObjectRow : WSSchemaObject

/*  Mainaining a reference to the column for sorting and labeling purposes.
    This labeling pattern probably isn't the best UX.
 */

@property (nonatomic) WSSchemaObjectColumn *orderColumn;
@property (nonatomic) WSSchemaObjectTable *parentTable;


/* I chose to use a dictionary here in case I needed to map the values to specific columns
   without the expense of iterating across every item in the collection and comparing
   properties to find the correct column name.
*/
//Store (K,V) pairs for each row.
//Key is the column name. Value is a WSField object.
//
@property (nonatomic) NSMutableDictionary *fields;


@end
