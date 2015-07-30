//
//  WSSQLiteHelper.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/26/15.
//
//

#import <Foundation/Foundation.h>

@class WSSchemaObjectTable;
@class WSSchemaObjectColumn;
@class WSCustomer;

@interface WSSQLiteHelper : NSObject

typedef void(^SuccessCompletionBlock)(BOOL success, NSError* error);
typedef void(^SearchCompletionBlock)(NSArray* results, NSError* error);

+(WSSQLiteHelper*)sharedHelper;

//Returns a collection of WSTable objects.
//
-(NSArray*)getTableList;

//Returns a collection of WSColumn objects.
//
-(NSArray*)getColumnsForTable:(WSSchemaObjectTable*)table;

//Returns a virtualized array of WSRow objects.
//Each row object is populated with a collection of WSField objects.
//
-(NSArray*)getRowsForTable:(WSSchemaObjectTable *)table
           orderedByColumn:(WSSchemaObjectColumn*)column;

//Overloaded getRowsForTable that optionally allows the caller to sort the rows according to ascending.
//Defaults to descending.
//
-(NSArray*)getRowsForTable:(WSSchemaObjectTable *)table
           orderedByColumn:(WSSchemaObjectColumn*)column
                 ascending:(BOOL)ascending;

//Asynchronous versions of getter methods.
//
-(void)getAllCustomersWithCompletion:(SearchCompletionBlock)completion;

-(void)getInvoicesForCustomer:(WSCustomer*)customer
               withCompletion:(SearchCompletionBlock)completion;

@end
