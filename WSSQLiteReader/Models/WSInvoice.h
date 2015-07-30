//
//  WSInvoice.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/29/15.
//

#import <Foundation/Foundation.h>
#import "WSObjectProtocol.h"

#define kInvoiceInvoiceIdFieldName @"InvoiceId"
#define kInvoiceCustomerIdFieldName @"CustomerId"
#define kInvoiceInvoiceDateFieldName @"InvoiceDate"
#define kInvoiceBillingAddressFieldName @"BillingAddress"
#define kInvoiceBillingCityFieldName @"BillingCity"
#define kInvoiceBillingStateFieldName @"BillingState"
#define kInvoiceBillingCountryFieldName @"BillingCountry"
#define kInvoiceBillingPostalCodeFieldName @"BillingPostalCode"
#define kInvoiceTotalFieldName @"Total"

@class FMResultSet;

@interface WSInvoice : NSObject <WSObjectProtocol>

@property (nonatomic) int invoiceId;
@property (nonatomic) int customerId;
@property (nonatomic) NSDate *invoiceDate;
@property (nonatomic) NSString *billingAddress;
@property (nonatomic) NSString *billingCity;
@property (nonatomic) NSString *billingState;
@property (nonatomic) NSString *billingCountry;
@property (nonatomic) NSString *billingPostalCode;
@property (nonatomic) double total;


-(NSString*)invoiceSummary;

@end
