//
//  WSSQLiteHelper.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/26/15.
//
//

/**
    You'll notice that I use FMDatabase for accessing the SQLite file.  That's just my preference 
    since I have the most experience with that.  I have never used CoreData, but I have been told 
    that it is a poorly implemented API; badly documented and slow for large data sets. 
    I'm not against it, though, I just haven't used it.
 */

#import "WSSQLiteHelper.h"
#import "WSFileHelper.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

#import "WSSchemaObject.h"
#import "WSSchemaObjectTable.h"
#import "WSSchemaObjectColumn.h"
#import "WSSchemaObjectRow.h"

#import "WSDataObject.h"

#import "WSObjectProtocol.h"
#import "WSCustomer.h"
#import "WSInvoice.h"

@implementation WSSQLiteHelper

#pragma mark - Singleton
+ (WSSQLiteHelper*)sharedHelper
{
    static WSSQLiteHelper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WSSQLiteHelper alloc] init];
    });
    
    return sharedInstance;
}


- (FMDatabase*)getFMDB
{
    NSString *localDBPath = [[WSFileHelper sharedHelper] getSQLiteDBPath];
    
    FMDatabase *db = [FMDatabase databaseWithPath:localDBPath];
    if (db == nil)
    {
        //TODO Alert user
    }
    
    return db;
}

#pragma mark - Getter methods
-(NSArray*)getTableList
{
    FMDatabase *db = [self getFMDB];
    if (![db openWithFlags:SQLITE_OPEN_READONLY]) {
        return nil;
    }
    
    /**
     I realize that the impact on a release version for one or two logging events may be
     negligable, but complex apps can potentially have many logs being written. Therefore, I've
     gotten into the habit of wrapping NSLog or any type of default logging functions with DEBUG 
     preprocessor directives.
     */
#if DEBUG
    db.logsErrors = YES;
#endif
    
    /**
     [FMDatabase getSchema] is a simple method for grabbing all of the schema data quickly. 
     Sorting out the tables (or views, or indexes) is a simple matter.
     */
    
    NSMutableArray *tables = [NSMutableArray array];
    FMResultSet *rs = [db getSchema];
    while ([rs next])
    {
        if ([[rs stringForColumnIndex:0] isEqualToString:@"table"])
        {
            WSSchemaObjectTable *table = (WSSchemaObjectTable*)[WSSchemaObject initWithObjectType:WSSchemaObjectTypeTable
                                                                                    andObjectName:[rs stringForColumnIndex:2]
                                                                                   andParentTable:nil];
            [tables addObject:table];
        }
    }
    [rs close];
    [db close];
    
    return [NSArray arrayWithArray:tables];
}

-(NSArray*)getColumnsForTable:(WSSchemaObjectTable*)table
{
    FMDatabase *db = [self getFMDB];
    if (![db openWithFlags:SQLITE_OPEN_READONLY]) {
        return nil;
    }
    
#if DEBUG
    db.logsErrors = YES;
#endif
    
    NSMutableArray *columns = [NSMutableArray array];
    
    /** 
     Again, [FMDatabase getTableSchema:] is just a great simple method for quickly grabbing all of 
     the table schema data.
     */
    
    FMResultSet *rs = [db getTableSchema:[table getObjectName]];
    while([rs next])
    {
        WSSchemaObjectColumn *column = (WSSchemaObjectColumn*)[WSSchemaObjectColumn initWithObjectType:WSSchemaObjectTypeColumn
                                                                                         andObjectName:[rs stringForColumnIndex:1]
                                                                                        andParentTable:table];
        column.columnId = [rs intForColumnIndex:0];
        column.dataType = [self dataTypeForTypeName:[rs stringForColumnIndex:2]];
        column.notnull = [rs boolForColumnIndex:3];
        column.defaultValue = [rs stringForColumnIndex:4];
        column.primaryKey = [rs boolForColumnIndex:5];
        
        [columns addObject:column];
    }
    [rs close];
    [db close];
    
    return [NSArray arrayWithArray:columns];
}

-(NSArray*)getRowsForTable:(WSSchemaObjectTable *)table
           orderedByColumn:(WSSchemaObjectColumn*)column
{
    return [self getRowsForTable:table orderedByColumn:column ascending:YES];
}

-(NSArray*)getRowsForTable:(WSSchemaObjectTable *)table
           orderedByColumn:(WSSchemaObjectColumn*)column
                 ascending:(BOOL)ascending
{
    
    /*  
        Since I don't know the data types or column names in advance at this point, I need to reference the
        columns collection for this table in order to properly create the fields for each row.
        Not terribly efficient, but effective for getting the data on the fly..
    */
    NSArray *columns = [self getColumnsForTable:table];
    
    FMDatabase* db = [self getFMDB];
    if (![db openWithFlags:SQLITE_OPEN_READONLY]) {
        return nil;
    }
    
#if DEBUG
    db.logsErrors = YES;
#endif
    
    NSMutableArray *allrows = [NSMutableArray array];
    
    NSMutableString *query = [NSMutableString string];
    [query appendFormat:@"SELECT * FROM %@", [table getObjectName]];

    FMResultSet *rs = [db executeQuery:query];
    
    while([rs next])
    {
        WSSchemaObjectRow *row = (WSSchemaObjectRow*)[WSSchemaObjectRow initWithObjectType:WSSchemaObjectTypeRow
                                                                             andObjectName:@""
                                                                            andParentTable:table];
        row.orderColumn = column;
        
        for (WSSchemaObjectColumn* col in columns)
        {
            WSDataObject *field = (WSDataObject*)[WSDataObject createDataObjectWithDataType:col.dataType
                                                                           andAttributeName:[col getObjectName]
                                                                              withResultSet:rs
                                                                               andFieldName:[col getObjectName]];

            [row.fields setObject:field forKey:[col getObjectName]];
        }
        
        
        NSString *columnName = [column getObjectName];
        WSDataObject *data = [row.fields objectForKey:columnName];
        row.objectName = [data getObjectValue];
        
        [allrows addObject:row];
    }
    [rs close];
    [db close];
    
    //Sort the rows
    //
    //TODO This sort is proving unreliable/unpredictable in a generic application.
    //     I need to write a more customized algorithm for alternate data types.
    //
    NSArray *sortedArray;
    sortedArray = [allrows sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        WSDataObject *dataField1 = [((NSDictionary*)((WSSchemaObjectRow*)a).fields) objectForKey:[column getObjectName]];
        WSDataObject *dataField2 = [((NSDictionary*)((WSSchemaObjectRow*)b).fields) objectForKey:[column getObjectName]];
        NSString *first = [(WSDataObject*)dataField1 getAttributeName];
        NSString *second = [(WSDataObject*)dataField2 getAttributeName];
        
        if (ascending)
            return [first compare:second];
        else
            return [second compare:first];
    }];
    
    return [NSArray arrayWithArray:sortedArray];
}

/*  
    It would have been possible to load the customers and their decendant objects
    by modifying the SQL to include a JOIN ON the Invoice.CustomerId and Customer.CustomerId column,
    but in this case I chose to handle these calls seperately to cut down on the load time.  I realize 
    that for such a small data set the load time is incredibly short, but I'm thinking of a larger data set
    possibly in the future.
    If the database were not local, however, I would definitely choose to fully populate the Customer objects
    to remove redundant service calls.
 */
-(NSArray*)getAllCustomers
{
    FMDatabase* db = [self getFMDB];
    if (![db openWithFlags:SQLITE_OPEN_READONLY]) {
        return nil;
    }
    
#if DEBUG
    db.logsErrors = YES;
#endif
    
    NSMutableArray *customers = [NSMutableArray array];
    
    NSMutableString *query = [NSMutableString string];
    [query appendString:@"SELECT * FROM Customer"];
    FMResultSet *rs = [db executeQuery:query];
    
    while([rs next])
    {
        [customers addObject:[[WSCustomer alloc] initWithResultSet:rs]];
    }
    [rs close];
    [db close];
    
    return [NSArray arrayWithArray:customers];
}


-(NSArray*)getInvoicesForCustomer:(WSCustomer*)customer
{
    FMDatabase* db = [self getFMDB];
    if (![db openWithFlags:SQLITE_OPEN_READONLY]) {
        return nil;
    }
    
#if DEBUG
    db.logsErrors = YES;
#endif
    
    NSMutableArray *invoices = [NSMutableArray array];
    
    NSMutableString *query = [NSMutableString string];
    [query appendFormat:@"SELECT * FROM Invoice i WHERE i.CustomerId = '%d'", customer.customerId];
    FMResultSet *rs = [db executeQuery:query];
    
    while([rs next])
    {
        [invoices addObject:[[WSInvoice alloc] initWithResultSet:rs]];
    }
    [rs close];
    [db close];
    
    return [NSArray arrayWithArray:invoices];
}

#pragma mark - Asynchronous getter methods.
-(void)getTableListWithCompletion:(SearchCompletionBlock)completion
{
    NSArray *tables = [self getTableList];
    if (!tables)
    {
#if DEBUG
        NSLog(@"Error retrieving tables.");
#endif
        NSError *err = [NSError errorWithDomain:@"HAAS" code:1 userInfo:[NSDictionary dictionaryWithObject:@"Error retrieving tables." forKey:@"message"]];
        completion(nil, err);
    }
    completion(tables, nil);
}


-(void)getColumnsForTable:(WSSchemaObjectTable*)table
           withCompletion:(SearchCompletionBlock)completion
{
    NSArray *columns = [self getColumnsForTable:table];
    if (!columns)
    {
#if DEBUG
        NSLog(@"Error retrieving columns.");
#endif
        NSError *err = [NSError errorWithDomain:@"HAAS" code:1 userInfo:[NSDictionary dictionaryWithObject:@"Error retrieving columns." forKey:@"message"]];
        completion(nil, err);
    }
    completion(columns, nil);
}

-(void)getRowsForTable:(WSSchemaObjectTable *)table
       orderedByColumn:(WSSchemaObjectColumn *)column
        withCompletion:(SearchCompletionBlock)completion
{
    NSArray *rows = [self getRowsForTable:table orderedByColumn:column];
    if (!rows)
    {
#if DEBUG
        NSLog(@"Error retrieving rows.");
#endif
        NSError* err = [NSError errorWithDomain:@"HAAS" code:1 userInfo:[NSDictionary dictionaryWithObject:@"Error retrieving rows." forKey:@"message"]];
        completion(nil, err);
    }
    completion(rows, nil);
}

-(void)getRowsForTable:(WSSchemaObjectTable *)table
       orderedByColumn:(WSSchemaObjectColumn*)column
             ascending:(BOOL)ascending
        withCompletion:(SearchCompletionBlock)completion
{
    NSArray *rows = [self getRowsForTable:table orderedByColumn:column ascending:ascending];
    if (!rows)
    {
#if DEBUG
        NSLog(@"Error retrieving rows.");
#endif
        NSError* err = [NSError errorWithDomain:@"HAAS" code:1 userInfo:[NSDictionary dictionaryWithObject:@"Error retrieving rows." forKey:@"message"]];
        completion(nil, err);
    }
    completion(rows, nil);
}

-(void)getAllCustomersWithCompletion:(SearchCompletionBlock)completion
{
    NSArray *rows = [self getAllCustomers];
    if (!rows)
    {
#if DEBUG
        NSLog(@"Error retrieving rows.");
#endif
        NSError* err = [NSError errorWithDomain:@"HAAS" code:1 userInfo:[NSDictionary dictionaryWithObject:@"Error retrieving rows." forKey:@"message"]];
        completion(nil, err);
    }
    completion(rows, nil);
}

-(void)getInvoicesForCustomer:(WSCustomer*)customer
               withCompletion:(SearchCompletionBlock)completion
{
    NSArray *rows = [self getInvoicesForCustomer:customer];
    if (!rows)
    {
#if DEBUG
        NSLog(@"Error retrieving rows.");
#endif
        NSError* err = [NSError errorWithDomain:@"HAAS" code:1 userInfo:[NSDictionary dictionaryWithObject:@"Error retrieving rows." forKey:@"message"]];
        completion(nil, err);
    }
    completion(rows, nil);
}

#pragma mark - Helper methods

-(WSDataType)dataTypeForTypeName:(NSString*)typeName
{
    
    if ([typeName isEqualToString:@"INTEGER"])
        return WSDataTypeInteger;
    else if ([typeName containsString:@"NVARCHAR"])
        return WSDataTypeText;
    else if ([typeName containsString:@"NUMERIC("])
        return WSDataTypeFloat64;
    else if ([typeName containsString:@"UUIDTEXT"])
        return WSDataTypeUUIDText;
    else if ([typeName containsString:@"REALDATE"])
        return WSDataTypeRealDate;
    else if ([typeName containsString:@"INT16"])
        return WSDataTypeBoolean;  //TODO This is stupid (bordering on insane). Do better.
    else
        return WSDataTypeLongLong;
}

@end
