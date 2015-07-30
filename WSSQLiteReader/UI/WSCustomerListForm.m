//
//  WSCustomerListForm.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/29/15.
//

#import "WSCustomerListForm.h"
#import "WSAppSettings.h"
#import "WSTextFieldItem.h"
#import "WSSQLiteHelper.h"
#import "WSCustomerDataForm.h"
#import "WSCustomer.h"
#import "WSPropertyFormItem.h"

@interface WSCustomerListForm () <WSPropertyFormItemDelegate>

@property (nonatomic) NSArray *customers;
@property (nonatomic) WSFormSection *customerListSection;

@end

@implementation WSCustomerListForm

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [WSAppSettings sharedSettings].theme.backgroundColor;
    self.title = @"All Customers";
    
    //TODO Add a spinner view here
    
    /*
     Since this list could be significant in time, its best to use the asynchronous method for loading the data here.
     */
    [[WSSQLiteHelper sharedHelper] getAllCustomersWithCompletion:^(NSArray *results, NSError *error) {
       if (error)
       {
           //TODO Alert user
       }
        _customers = results;
        [self configureDataSource];
    }];
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
    [sections addObject:[self customerListSection]];
    
    self.formDataSource = sections;
}

-(WSFormSection*)customerListSection
{
    if (!_customerListSection) {
        _customerListSection = [WSFormSection sectionWithTitle:@"Customers"];
        _customerListSection.delegate = self;
    }
    [_customerListSection.rows removeAllObjects];
    
    for (WSCustomer *customer in self.customers)
    {
        WSTextFieldItem *item = [[WSTextFieldItem alloc] initWithTitle:@"Customer"
                                                                 model:customer
                                                             attribute:nil];
        item.inputType = WSTextFieldTableViewCellInputTypeText;
        item.content = customer.fullName;
        
        [_customerListSection.rows addObject:item];
    }
    
    return _customerListSection;
}


-(void)didSelectCellForItem:(WSFormItem *)item
{
    WSCustomer *customer = (WSCustomer*)((WSPropertyFormItem*)item).model;
    WSCustomerDataForm *dataFormVC = [[WSCustomerDataForm alloc] initWithCustomer:customer];
    
    [self.navigationController pushViewController:dataFormVC animated:YES];
}

@end
