//
//  WSInvoice.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/29/15.
//

#import <Foundation/Foundation.h>
#import "WSObjectProtocol.h"

extern NSString* const kInvoiceTableName;
extern NSString* const kInvoiceInvoiceIdFieldName;
extern NSString* const kInvoiceCustomerIdFieldName;
extern NSString* const kInvoiceInvoiceDateFieldName;
extern NSString* const kInvoiceBillingAddressFieldName;
extern NSString* const kInvoiceBillingCityFieldName;
extern NSString* const kInvoiceBillingStateFieldName;
extern NSString* const kInvoiceBillingCountryFieldName;
extern NSString* const kInvoiceBillingPostalCodeFieldName;
extern NSString* const kInvoiceTotalFieldName;

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
