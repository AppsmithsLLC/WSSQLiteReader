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
    Although some define all constants in a central location, I prefer not to do this because
    1) those files can grow to the point of being unmanageable, and 
    2) I think that defining them in each model class is a good logical seperation.
 
    I have recently begun to define my constants using extern per Apple's recommendation
    https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CodingGuidelines/Articles/NamingIvarsAndTypes.html#//apple_ref/doc/uid/20001284-1003095
 */

extern NSString* const kCustomerTableName;
extern NSString* const kCustomerCustomerIdFieldName;
extern NSString* const kCustomerFirstNameFieldName;
extern NSString* const kCustomerLastNameFieldName;
extern NSString* const kCustomerCompanyFieldName;
extern NSString* const kCustomerAddressFieldName;
extern NSString* const kCustomerCityFieldName;
extern NSString* const kCustomerStateFieldName;
extern NSString* const kCustomerCountryFieldName;
extern NSString* const kCustomerPostalCodeFieldName;
extern NSString* const kCustomerPhoneFieldName;
extern NSString* const kCustomerFaxFieldName;
extern NSString* const kCustomerEmailFieldName;
extern NSString* const kCustomerSupportRepIdFieldName;

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
