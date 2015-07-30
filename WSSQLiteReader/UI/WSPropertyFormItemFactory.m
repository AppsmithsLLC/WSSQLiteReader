//
//  WSPropertyFormItemFactory.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/26/15.
//

#import "WSPropertyFormItemFactory.h"
#import "WSSchemaObjectColumn.h"

#import "WSTextFieldItem.h"
#import "WSTextViewItem.h"
#import "WSDatePickerDisplayItem.h"
#import "WSSwitchItem.h"
#import "WSDropdownItem.h"

#import "WSDataObject.h"
#import "WSDataObjectStringField.h"
#import "WSDataObjectNumberField.h"
#import "WSDataObjectDateField.h"
#import "WSDataObjectBoolField.h"

#import "WSSchemaObject.h"
#import "WSSchemaObjectColumn.h"
#import "WSSchemaObjectTable.h"
#import "WSSchemaObjectRow.h"

#import "WSTextFieldTableViewCell.h"

@implementation WSPropertyFormItemFactory

NSString * const WSFieldType_toString[] = {
    [WSFieldTypeStringField] = @"StringField",
    [WSFieldTypeNumberField] = @"NumberField",
    [WSFieldTypeDateField] = @"DateField",
    [WSFieldTypeBoolField] = @"BoolField"
};

NSString * const WSSchemaObjectType_toString[] = {
    [WSSchemaObjectTypeColumn] = @"Column",
    [WSSchemaObjectTypeRow] = @"Row",
    [WSSchemaObjectTypeTable] = @"Table"
};

+ (id<WSPropertyFormItemDelegate>) createFormItemForDataObject:(WSDataObject*)dataObject isEditable:(BOOL)isEditable
{
    switch ([dataObject getDataType]) {
        case WSDataTypeText:
        {
            WSTextViewItem *textView = [[WSTextViewItem alloc] initWithTitle:[((WSDataObject*)dataObject) getFieldName]
                                                                          model:dataObject
                                                                      attribute:[dataObject getAttributeName]];
            
            textView.editable = isEditable;
            return textView;
        }
        case WSDataTypeUUIDText:
        {
            WSTextFieldItem *textField = [[WSTextFieldItem alloc] initWithTitle:[((WSDataObject*)dataObject) getFieldName]
                                                                          model:dataObject
                                                                      attribute:[dataObject getAttributeName]];
            
            textField.inputType = WSTextFieldTableViewCellInputTypeText;
            textField.editable = isEditable;
            return textField;
        }
        case WSDataTypeInteger:
        case WSDataTypeInt16:
        case WSDataTypeInt32:
        case WSDataTypeLongLong:
        {
            WSTextFieldItem *textField = [[WSTextFieldItem alloc] initWithTitle:[((WSDataObject*)dataObject) getFieldName]
                                                                          model:dataObject
                                                                      attribute:[dataObject getAttributeName]];
            
            textField.inputType = WSTextFieldTableViewCellInputTypeInteger;
            textField.editable = isEditable;
            return textField;
        }
        case WSDataTypeFloat64:
        {
            WSTextFieldItem *textField = [[WSTextFieldItem alloc] initWithTitle:[((WSDataObject*)dataObject) getFieldName]
                                                                          model:dataObject
                                                                      attribute:[dataObject getAttributeName]];
            
            textField.inputType = WSTextFieldTableViewCellInputTypeDecimal;
            textField.editable = isEditable;
            return textField;
        }
        case WSDataTypeRealDate:
        {
            return [[WSDatePickerDisplayItem alloc] initWithTitle:[((WSDataObject*)dataObject) getFieldName]
                                                            model:dataObject
                                                        attribute:[dataObject getAttributeName]];
        }
        case WSDataTypeBoolean:
        {
            return [[WSSwitchItem alloc] initWithTitle:[((WSDataObject*)dataObject) getFieldName]
                                                 model:dataObject
                                             attribute:[dataObject getAttributeName]];
        }
    }
}

+ (id<WSPropertyFormItemDelegate>) createFormItemForSchemaObject:(WSSchemaObject*)schemaObject
                                                      isEditable:(BOOL)isEditable
{
    switch ([schemaObject getSchemaType]) {
        case WSSchemaObjectTypeColumn:
        case WSSchemaObjectTypeTable:
        {
            WSDropdownItem *dropdownItem = [[WSDropdownItem alloc] initWithTitle:schemaObject.objectName
                                                                           model:schemaObject
                                                                       attribute:nil
                                                                       cellStyle:UITableViewCellStyleDefault];
            
            dropdownItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            dropdownItem.editable = isEditable;
            return dropdownItem;
        }
            
        case WSSchemaObjectTypeRow:
        {
            WSDropdownItem *dropdownItem = [[WSDropdownItem alloc] initWithTitle:[((WSSchemaObjectRow*)schemaObject) getObjectName]
                                                                           model:schemaObject
                                                                       attribute:nil
                                                                       cellStyle:UITableViewCellStyleDefault];
            
            dropdownItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            dropdownItem.editable = isEditable;
            return dropdownItem;
        }
    }
}

@end
