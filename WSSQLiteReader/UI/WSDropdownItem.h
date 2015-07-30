//
//  WSDropdownItem.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/28/15.
//  Copyright (c) 2015 Websmiths, LLC. All rights reserved.
//

#import "WSPropertyFormItem.h"

// A form item that displays it's title property as content
// This can be used in generic scenarios where you need more fine grained control
// when the user selects the form item. For example, if you need to open a
// new view controller when the user clicks the item this provides the flexibility
//

@interface WSDropdownItem : WSPropertyFormItem <WSPropertyFormItemDelegate>

- (instancetype)initWithTitle:(NSString *)title
                        model:(id)model
                    attribute:(NSString *)attribute
                    cellStyle:(UITableViewCellStyle)style;

// Initializes the cell with a title and static content. Puts the cell into
// readonly mode
//
- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content;

@property (nonatomic) NSString *subtitle;
@property (nonatomic) UITableViewCellAccessoryType accessoryType;

@end
