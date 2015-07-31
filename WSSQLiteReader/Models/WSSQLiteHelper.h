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

//Returns all tables from the database as an NSArray of WSSchemaObjectTable objects.
//
//
-(NSArray*)getTableList;

//Returns all columns from the specified table as an NSArray of WSSchemaObjectColumn objects.
//
-(NSArray*)getColumnsForTable:(WSSchemaObjectTable*)table;

// Returns aall rows of the specified table as an array of WSSchemaObjectRow objects.
// Each row object contains a reference to the parent table object and a column used to sort the rows.
// Each row is populated with a collection of WSDataObjectField objects.
//
-(NSArray*)getRowsForTable:(WSSchemaObjectTable *)table
           orderedByColumn:(WSSchemaObjectColumn*)column;

//Overloaded getRowsForTable that optionally allows the caller to sort the rows according to ascending.
//Defaults to descending.
//
-(NSArray*)getRowsForTable:(WSSchemaObjectTable *)table
           orderedByColumn:(WSSchemaObjectColumn*)column
                 ascending:(BOOL)ascending;

/* 
 I chose to create a couple of asynchronous method calls to demonstrate my understanding of 
 multithreading and blocks.  In the real world, I would not typically define methods this rigid, but would 
 instead include some sort of WHERE clause parameter to filter the search by.
 */

//Asynchronous call to get all Customer data from the Customer table.
//SearchCompletionBlock returns an array of WSCustomer objects and an NSError object.
//
-(void)getAllCustomersWithCompletion:(SearchCompletionBlock)completion;

//Asynchronous call to get all Invoice data for the specified Customer.
//SearchCompletionBlock returns an array of WSInvoice objects and an NSError object.
//
-(void)getInvoicesForCustomer:(WSCustomer*)customer
               withCompletion:(SearchCompletionBlock)completion;

@end
