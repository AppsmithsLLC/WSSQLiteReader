//
//  WSCustomer.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/29/15.
//

#import <Foundation/Foundation.h>
#import "WSObjectProtocol.h"
/*  
    I define constants for table and column names within the matching data model class.
    I use these constants for dictionary keys, and to have consistently formatted SQL
    in my helper class.
    Although some define all constants ina central location, I prefer not to do this because
    1) those files can grow to the point of being unmanageable, and 
    2) I think that defining them in each model class is a good logical seperation.
 */

#define kCustomerTableName @"Customer"
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
