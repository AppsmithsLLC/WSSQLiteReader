//
//  WSInvoice.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/29/15.
//

#import "WSInvoice.h"
#import "FMDatabase.h"

@implementation WSInvoice


-(instancetype)initWithResultSet:(FMResultSet*)resultSet
{
    self = [super init];
    if (self)
    {
        [self configureDataFromResultSet:resultSet];
    }
    
    return self;
}

-(void)configureDataFromResultSet:(FMResultSet*)rs
{
    _invoiceId = [rs intForColumn:kInvoiceInvoiceIdFieldName];
    _customerId = [rs intForColumn:kInvoiceCustomerIdFieldName];
    _invoiceDate = [self getDateFromSQLiteDateString:[rs stringForColumn:kInvoiceInvoiceDateFieldName]];
    _billingAddress = [rs stringForColumn:kInvoiceBillingAddressFieldName];
    _billingCity = [rs stringForColumn:kInvoiceBillingCityFieldName];
    _billingState = [rs stringForColumn:kInvoiceBillingStateFieldName];
    _billingCountry = [rs stringForColumn:kInvoiceBillingCountryFieldName];
    _billingPostalCode = [rs stringForColumn:kInvoiceBillingPostalCodeFieldName];
    _total = [rs doubleForColumn:kInvoiceTotalFieldName];
}

-(NSString*)invoiceSummary
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd, yyyy"];
    NSString* date = [formatter stringFromDate:self.invoiceDate];
    
    return [NSString stringWithFormat:@"%@ - $%.2f", date, self.total];
}

/* 
    SQLite stores date values as DATETIME which FMResultSet does not return in
    an NSDate compatible format.  This formatter resolves that.
    If I want to save values in the future, I will need to create a reverse formatter.
    Or I could just store dates to a text column in Unix format.
 */
-(NSDate*)getDateFromSQLiteDateString:(NSString*)sqliteDateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-mm-dd hh:mm:ss"];

    return [dateFormatter dateFromString:sqliteDateString];
}
@end
