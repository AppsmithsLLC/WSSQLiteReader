//
//  WSCustomer.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/29/15.
//

#import <Foundation/Foundation.h>
#import "WSObjectProtocol.h"

#define kCustomerCustomerIdFieldName @"CustomerId"
#define kCustomerFirstNameFieldName @"FirstName"
#define kCustomerLastNameFieldName @"LastName"
#define kCustomerCompanyFieldName @"Company"
#define kCustomerAddressFieldName @"Address"
#define kCustomerCityFieldName @"City"
#define kCustomerStateFieldName @"State"
#define kCustomerCountryFieldName @"Country"
#define kCustomerPostalCodeFieldName @"PostalCode"
#define kCustomerPhoneFieldName @"Phone"
#define kCustomerFaxFieldName @"Fax"
#define kCustomerEmailFieldName @"Email"
#define kCustomerSupportRepIdFieldName @"SupportRepId"

@class FMResultSet;

@interface WSCustomer : NSObject <WSObjectProtocol>

@property (nonatomic) int customerId;
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *company;
@property (nonatomic) NSString *address;
@property (nonatomic) NSString *city;
@property (nonatomic) NSString *state;
@property (nonatomic) NSString *country;
@property (nonatomic) NSString *postalCode;
@property (nonatomic) NSString *phone;
@property (nonatomic) NSString *fax;
@property (nonatomic) NSString *email;
@property (nonatomic) int supportRepId;

//Convenience property
//
@property (nonatomic) NSArray* invoices;

-(NSString*)fullName;


@end
