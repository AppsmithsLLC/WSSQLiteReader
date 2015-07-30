//
//  WSSchemaObjectRow.h
//  WSDatabaseReader
//
//  Created by William Smith on 7/22/15.
//

#import "WSDataObject.h"

@class WSSchemaObjectColumn;
@class WSSchemaObjectTable;

@interface WSSchemaObjectRow : WSSchemaObject <WSSchemaObjectProtocol>

/*  Mainaining a reference to the column for sorting and labeling purposes.
    This labeling pattern probably isn't the best UX.
    References are weak to prevent memory leaks due to the potential for large volumes of records.
    Table reference is readonly for security purposes; if I ever decide to allow editing, the edited record
        will be saved using the referenced table as a parameter in the SQL update statement so I don't want 
        the caller to be able to change that.  I don't have this concern for the orderColumn object because
        each data object in the fields dictionary maintains a reference to its own column name.
 */
//TODO Change column in Row DataObjectField... to readonly.

@property (nonatomic, weak) WSSchemaObjectColumn *orderColumn;
@property (nonatomic, readonly, weak) WSSchemaObjectTable *parentTable;


/* I chose to use a dictionary here in case I needed to map the values to specific columns
   without the expense of iterating across every item in the collection and comparing
   properties to find the correct column name.
*/
//Store (K,V) pairs for each row.
//Key is the column name. Value is a WSField object.
//
@property (nonatomic) NSMutableDictionary *fields;


@end
