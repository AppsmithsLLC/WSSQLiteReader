//
//  WSCustomer.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/29/15.
//

#import "WSCustomer.h"
#import "FMDatabase.h"


NSString* const kCustomerTableName = @"Customer";
NSString* const kCustomerCustomerIdFieldName = @"CustomerId";
NSString* const kCustomerFirstNameFieldName = @"FirstName";
NSString* const kCustomerLastNameFieldName = @"LastName";
NSString* const kCustomerCompanyFieldName = @"Company";
NSString* const kCustomerAddressFieldName = @"Address";
NSString* const kCustomerCityFieldName = @"City";
NSString* const kCustomerStateFieldName = @"State";
NSString* const kCustomerCountryFieldName = @"Country";
NSString* const kCustomerPostalCodeFieldName = @"PostalCode";
NSString* const kCustomerPhoneFieldName = @"Phone";
NSString* const kCustomerFaxFieldName = @"Fax";
NSString* const kCustomerEmailFieldName = @"Email";
NSString* const kCustomerSupportRepIdFieldName = @"SupportRepId";

@implementation WSCustomer

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
    _customerId = [rs intForColumn:kCustomerCustomerIdFieldName];
    _firstName = [rs stringForColumn:kCustomerFirstNameFieldName];
    _lastName = [rs stringForColumn:kCustomerLastNameFieldName];
    _company = [rs stringForColumn:kCustomerCompanyFieldName];
    _address = [rs stringForColumn:kCustomerAddressFieldName];
    _city = [rs stringForColumn:kCustomerCityFieldName];
    _state = [rs stringForColumn:kCustomerStateFieldName];
    _country = [rs stringForColumn:kCustomerCountryFieldName];
    _postalCode = [rs stringForColumn:kCustomerPostalCodeFieldName];
    _phone = [rs stringForColumn:kCustomerPhoneFieldName];
    _fax = [rs stringForColumn:kCustomerFaxFieldName];
    _email = [rs stringForColumn:kCustomerEmailFieldName];
    _supportRepId = [rs intForColumn:kCustomerSupportRepIdFieldName];
}

-(NSString*)fullName
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}
@end
