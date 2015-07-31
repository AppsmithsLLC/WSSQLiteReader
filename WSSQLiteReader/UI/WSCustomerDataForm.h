//
//  WSCustomerDataForm.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/29/15.
//

#import "WSBaseForm.h"

@class WSCustomer;

@interface WSCustomerDataForm : WSBaseForm

/** 
    This design pattern gives me the flexibility to define custom initializers, properties and methods
    at the local level on an as-needed basis.
 */
-(instancetype)initWithCustomer:(WSCustomer*)customer;

@end
