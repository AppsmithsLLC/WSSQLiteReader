//
//  WSDynamicForm.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/26/15.
//

#import "WSDynamicForm.h"
#import "WSFormSection.h"
#import "WSTextFieldItem.h"
#import "WSDropdownItem.h"
#import "WSPropertyFormItemFactory.h"

#import "WSAppSettings.h"
#import "WSSchemaObject.h"
#import "WSDataObject.h"
#import "WSPropertyFormItem.h"

#import "WSSchemaObjectTable.h"
#import "WSSchemaObjectColumn.h"
#import "WSSchemaObjectRow.h"

#import "WSSQLiteHelper.h"


@interface WSDynamicForm () <WSPropertyFormItemDelegate>

@property (nonatomic) BOOL isSchemaData;

@end

@implementation WSDynamicForm



-(instancetype)initWithDataObjects:(NSDictionary *)dataObjects
                      andFormTitle:(NSString *)formTitle
{
    self = [super init];
    if (self)
    {
        //Always call the accessor instead of the public property to prevent unpredictable behavior from custom setters.
        //
        _dataObjects = dataObjects;
        _formTitle = formTitle;
        _isSchemaData = NO; //Redundant, but safe
    }
    
    return self;
}

-(instancetype)initWithSchemaObjects:(NSArray *)schemaObjects
                        andFormTitle:(NSString *)formTitle
{
    self = [super init];
    if (self)
    {
        //Always call the accessor instead of the public property to prevent unpredictable behavior from custom setters.
        //
        _schemaObjects = schemaObjects;
        _formTitle = formTitle;
        _isSchemaData = YES;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [WSAppSettings sharedSettings].theme.backgroundColor;
    self.title = self.formTitle;
    
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
    if (self.isSchemaData)
    {
        self.formDataSource = [self schemaObjectSection];
    }
    else
        self.formDataSource = [self dataObjectSection];
}

-(NSArray*)schemaObjectSection
{
    NSMutableArray *sections = [NSMutableArray array];
    WSFormSection *section = [[WSFormSection alloc] initWithTitle:@"Schema Objects"];
    [sections addObject:section];
    for (WSSchemaObject *schemaObject in self.schemaObjects) {
        
        WSPropertyFormItem* item = (WSPropertyFormItem*)[WSPropertyFormItemFactory createFormItemForSchemaObject:schemaObject isEditable:NO];
        item.delegate = self;
        [section.rows addObject:item];
    }
    
    return [NSArray arrayWithArray:sections];
}

-(NSArray*)dataObjectSection
{
    NSMutableArray *sections = [NSMutableArray array];
    WSFormSection *section = [[WSFormSection alloc] initWithTitle:@"Data Objects"];
    [sections addObject:section];
    for (NSString *key in self.dataObjects) {
        WSDataObject *dataObject = [self.dataObjects objectForKey:key];
        WSPropertyFormItem* item = (WSPropertyFormItem*)[WSPropertyFormItemFactory createFormItemForDataObject:dataObject isEditable:YES];
        item.delegate = self;
        [section.rows addObject:item];
    }
    
    return [NSArray arrayWithArray:sections];
}

#pragma mark - WSPropertyFormItemDelegate methods
-(void)didSelectCellForItem:(WSPropertyFormItem *)item
{
    /*
     This is just a crude way to prevent the user from tapping on a data cell.  I wouldn't do it this way if I had more time.
     */
    if (item.editable)
        return;
    
    switch ([((WSSchemaObject*)item.model) getSchemaType])
    {
        case WSSchemaObjectTypeColumn:
        {
            //Call a helper method to order the rows by the data in that column then display the rows with that data being shown as the label
            //Add rows array to the column object for a column ordered array of rows
            ((WSSchemaObjectColumn*)item.model).parentTable.rows = [[WSSQLiteHelper sharedHelper] getRowsForTable:((WSSchemaObjectColumn*)item.model).parentTable
                                                                                                  orderedByColumn:(WSSchemaObjectColumn*)item.model];
            
            WSDynamicForm *rowsVC = [[WSDynamicForm alloc] initWithSchemaObjects:((WSSchemaObjectColumn*)item.model).parentTable.rows
                                                                    andFormTitle:[NSString stringWithFormat:@"Rows sorted by %@", [((WSSchemaObjectTable*)item.model) getObjectName]]];
            
            [self.navigationController pushViewController:rowsVC animated:YES];
            return;
        }
        case WSSchemaObjectTypeRow:
        {
            WSDynamicForm *rowDataVC = [[WSDynamicForm alloc] initWithDataObjects:((WSSchemaObjectRow*)item.model).fields
                                                                     andFormTitle:[NSString stringWithFormat:@"Data for %@", [((WSSchemaObjectRow*)item.model) getObjectName]]];

            [self.navigationController pushViewController:rowDataVC animated:YES];
            break;
        }
        case WSSchemaObjectTypeTable:
        {
            ((WSSchemaObjectTable*)item.model).columns = [[WSSQLiteHelper sharedHelper] getColumnsForTable:item.model];
            
            WSDynamicForm *columnsVC = [[WSDynamicForm alloc] initWithSchemaObjects:((WSSchemaObjectTable*)item.model).columns
                                                                       andFormTitle:[NSString stringWithFormat:@"Columns for %@", [((WSSchemaObjectTable*)item.model) getObjectName]]];
            
            [self.navigationController pushViewController:columnsVC animated:YES];
            break;
        }
    }
}

@end
