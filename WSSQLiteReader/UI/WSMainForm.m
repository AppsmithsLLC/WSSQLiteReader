//
//  WSMainForm.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/29/15.
//

#import "WSMainForm.h"
#import "WSAppSettings.h"
#import "WSTextFieldItem.h"
#import "WSSQLiteHelper.h"
#import "WSDynamicForm.h"
#import "WSCustomerListForm.h"

@interface WSMainForm () <WSPropertyFormItemDelegate>

@property (nonatomic) WSFormSection *optionListSection;

#define DYNAMIC 1
#define CUSTOM 2

@end

@implementation WSMainForm

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [WSAppSettings sharedSettings].theme.backgroundColor;
    self.title = @"Choose Browse Method"; //Terrible title
    
    [self configureDataSource];
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
    [sections addObject:[self optionListSection]];
    
    self.formDataSource = sections;
}

-(WSFormSection*)optionListSection
{
    if (!_optionListSection) {
        _optionListSection = [WSFormSection sectionWithTitle:@"Options"];
        _optionListSection.delegate = self;
    }
    [_optionListSection.rows removeAllObjects];

    WSTextFieldItem *item = [[WSTextFieldItem alloc] initWithTitle:@"Dynamic" content:@"Browse data dynamically."];
    item.tableViewCell.tag = DYNAMIC;
    [_optionListSection.rows addObject:item];
    
    item = [[WSTextFieldItem alloc] initWithTitle:@"Custom (Chinook_Sqlite.sqlite ONLY!)" content:@"Use a custom built form."];
    item.tableViewCell.tag = CUSTOM;
    [_optionListSection.rows addObject:item];
    
    return _optionListSection;
}


-(void)didSelectCellForItem:(WSFormItem *)item
{
    if (item.tableViewCell.tag == DYNAMIC)
    {
        NSArray *dataObjects = [[WSSQLiteHelper sharedHelper] getTableList];
        WSDynamicForm *dynamic = [[WSDynamicForm alloc] initWithSchemaObjects:dataObjects
                                                                 andFormTitle:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"dbFileName"]];
        
        [self.navigationController pushViewController:dynamic animated:YES];
    }
    else //Custom
    {
        WSCustomerListForm *customerListVC = [[WSCustomerListForm alloc] init];
        
        [self.navigationController pushViewController:customerListVC animated:YES];
    }
}

@end
