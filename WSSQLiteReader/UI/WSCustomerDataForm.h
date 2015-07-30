//
//  WSCustomerDataForm.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/29/15.
//

#import "WSBaseForm.h"

@class WSCustomer;

@interface WSCustomerDataForm : WSBaseForm

-(instancetype)initWithCustomer:(WSCustomer*)customer;
@end
