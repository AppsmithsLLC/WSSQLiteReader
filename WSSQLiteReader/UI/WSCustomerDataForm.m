//
//  WSCustomerDataForm.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/29/15.
//

#import "WSCustomerDataForm.h"
#import "WSAppSettings.h"
#import "WSCustomer.h"
#import "WSInvoice.h"
#import "WSSQLiteHelper.h"

#import "WSTextFieldItem.h"

@interface WSCustomerDataForm ()

@property (nonatomic) WSCustomer *customer;
@property (nonatomic) WSFormSection *customerDataSection;
@property (nonatomic) WSFormSection *invoiceListSection;

@end

@implementation WSCustomerDataForm

-(instancetype)initWithCustomer:(WSCustomer *)customer
{
    self = [super init];
    if (self)
    {
        _customer = customer;
    }
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [WSAppSettings sharedSettings].theme.backgroundColor;
    self.title = _customer.fullName;
    
    if (self.customer.invoices)
    {
        [self configureDataSource];
    }
    else
    {
        //TODO Add a spinner view here
        [[WSSQLiteHelper sharedHelper] getInvoicesForCustomer:_customer withCompletion:^(NSArray *results, NSError *error) {
          if (error)
          {
              //Alert user
          }
            _customer.invoices = results;
            [self configureDataSource];
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)onCancel
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)configureDataSource
{
    NSMutableArray *sections = [NSMutableArray array];
    [sections addObject:[self customerDataSection]];
    [sections addObject:[self invoiceListSection]];
    
    self.formDataSource = sections;
}

-(WSFormSection*)customerDataSection
{
    if (!_customerDataSection) {
        _customerDataSection = [WSFormSection sectionWithTitle:@"Customer Data"];
        _customerDataSection.delegate = self;
    }
    [_customerDataSection.rows removeAllObjects];
    
    //CustomerId
    WSTextFieldItem *item = [[WSTextFieldItem alloc] initWithTitle:@"Customer Id"
                                                             model:self.customer
                                                         attribute:NSStringFromSelector(@selector(customerId))];
    item.inputType = WSTextFieldTableViewCellInputTypeInteger;
    
    [_customerDataSection.rows addObject:item];
    
    //FullName
    item = [[WSTextFieldItem alloc] initWithTitle:@"Customer Name"
                                            model:self.customer
                                        attribute:NSStringFromSelector(@selector(fullName))];
    item.inputType = WSTextFieldTableViewCellInputTypeText;
    
    [_customerDataSection.rows addObject:item];
    
    //Company
    item = [[WSTextFieldItem alloc] initWithTitle:@"Company"
                                            model:self.customer
                                        attribute:NSStringFromSelector(@selector(company))];
    item.inputType = WSTextFieldTableViewCellInputTypeText;
    
    [_customerDataSection.rows addObject:item];
    
    //Address
    item = [[WSTextFieldItem alloc] initWithTitle:@"Address"
                                            model:self.customer
                                        attribute:NSStringFromSelector(@selector(address))];
    item.inputType = WSTextFieldTableViewCellInputTypeText;
    
    [_customerDataSection.rows addObject:item];
    
    //City
    item = [[WSTextFieldItem alloc] initWithTitle:@"City"
                                            model:self.customer
                                        attribute:NSStringFromSelector(@selector(city))];
    item.inputType = WSTextFieldTableViewCellInputTypeText;
    
    [_customerDataSection.rows addObject:item];
    
    //State
    item = [[WSTextFieldItem alloc] initWithTitle:@"State"
                                            model:self.customer
                                        attribute:NSStringFromSelector(@selector(state))];
    item.inputType = WSTextFieldTableViewCellInputTypeText;
    
    [_customerDataSection.rows addObject:item];
    
    //Country
    item = [[WSTextFieldItem alloc] initWithTitle:@"Country"
                                            model:self.customer
                                        attribute:NSStringFromSelector(@selector(country))];
    item.inputType = WSTextFieldTableViewCellInputTypeText;
    
    [_customerDataSection.rows addObject:item];
    
    //PostalCode
    item = [[WSTextFieldItem alloc] initWithTitle:@"Postal Code"
                                            model:self.customer
                                        attribute:NSStringFromSelector(@selector(postalCode))];
    item.inputType = WSTextFieldTableViewCellInputTypeText;
    
    [_customerDataSection.rows addObject:item];
    
    
    //Phone
    item = [[WSTextFieldItem alloc] initWithTitle:@"Phone"
                                            model:self.customer
                                        attribute:NSStringFromSelector(@selector(phone))];
    item.inputType = WSTextFieldTableViewCellInputTypeText;
    
    [_customerDataSection.rows addObject:item];
    
    //Fax
    item = [[WSTextFieldItem alloc] initWithTitle:@"Fax"
                                            model:self.customer
                                        attribute:NSStringFromSelector(@selector(fax))];
    item.inputType = WSTextFieldTableViewCellInputTypeText;
    
    [_customerDataSection.rows addObject:item];
    
    //Email
    item = [[WSTextFieldItem alloc] initWithTitle:@"Email"
                                            model:self.customer
                                        attribute:NSStringFromSelector(@selector(email))];
    item.inputType = WSTextFieldTableViewCellInputTypeText;
    
    [_customerDataSection.rows addObject:item];
    
    //SupportRepId
    item = [[WSTextFieldItem alloc] initWithTitle:@"Support Rep Id"
                                            model:self.customer
                                        attribute:NSStringFromSelector(@selector(supportRepId))];
    item.inputType = WSTextFieldTableViewCellInputTypeInteger;
    
    [_customerDataSection.rows addObject:item];
    
    return _customerDataSection;
}


-(WSFormSection*)invoiceListSection
{
    if (!_invoiceListSection) {
        _invoiceListSection = [WSFormSection sectionWithTitle:@"Invoices"];
        _invoiceListSection.delegate = self;
    }
    [_invoiceListSection.rows removeAllObjects];
    
    for (WSInvoice *invoice in self.customer.invoices)
    {
        WSTextFieldItem *item = [[WSTextFieldItem alloc] initWithTitle:[NSString stringWithFormat:@"Invoice Number: %d", invoice.invoiceId]
                                                                 model:invoice
                                                             attribute:NSStringFromSelector(@selector(invoiceSummary))];
        item.inputType = WSTextFieldTableViewCellInputTypeText;
        
        [_invoiceListSection.rows addObject:item];
    }
    
    return _invoiceListSection;
}

@end
