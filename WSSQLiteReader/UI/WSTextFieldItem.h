//
//  WSTextFieldItem.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import "WSPropertyFormItem.h"
#import "WSTextFieldTableViewCell.h"

@class WSTextFieldTableViewCell;

@interface WSTextFieldItem : WSPropertyFormItem <WSPropertyFormItemDelegate>

- (WSTextFieldTableViewCell *)tableViewCell;

// Specifies whether the cell text can be edited or not.
//
@property (nonatomic,getter=isReadOnly) BOOL readOnly;

// Support for static content unrelated to an attribute
//
@property (nonatomic) NSString *content;

// Cell configuration properties
//
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *placeholder;

// A passthrough down to the WSTextFieldTableViewCell
//
@property (nonatomic) WSTextFieldTableViewCellInputType inputType;

//A simoe initializer that displays content and sets the cell to readonly.
//
- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content;


@end
