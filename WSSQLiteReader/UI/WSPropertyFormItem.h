//
//  WSPropertyFormItem.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import <UIKit/UIKit.h>

@class WSPropertyFormItem;

@protocol WSPropertyFormItemDelegate <NSObject>

@optional

// Notifies the delegate to push a new view controller onto the stack
//
-(void)pushViewController:(UIViewController *)controller
                  forItem:(WSPropertyFormItem *)item;

// Notifies the delegate to display a new content popover positioned at the
// input view (sender)
//
-(void)showPopupWithController:(UIViewController *)controller
                       forItem:(WSPropertyFormItem *)item
                      fromView:(UIView *)sender;

// Notifies the delegate to present a new view controller
//
-(void)presentViewController:(UIViewController *)controller
                     forItem:(WSPropertyFormItem *)item;

- (void)dismissPopup;

- (void)didSelectCellForItem:(WSPropertyFormItem *)item;

// Called whenever a new value is set for the item and it's corresponding model object(s)
//
- (void)didUpdateValueForItem:(WSPropertyFormItem *)item;

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// A wrapper class which is equivalent to a view controller for a UITableViewCell.
// This class provides a view and a standard height for that view so that
// it is abstracted away from UITableViewController subclasses.
//
// Note: Does not currently support the reusability options of UITableView
//
@interface WSFormItem : NSObject

/**
    I define the UITableViewCell as a public property in the base class.  I then override the getter in
    each custom wrapper class that inherits from this.  In that getter I customize the data for each
    xib file as needed.  Again, the complexity is abstracted away from the caller leaving behind a clean
    and efficient implementation.
 
    See demonstrations of this in WSCustomerListForm, WSCustomerDataForm, WSDynamicForm and WSMainForm.
 */
// A view for the cell
//
- (UITableViewCell *)tableViewCell;

// The height for the corresponding cell
//
@property (nonatomic, readonly) CGFloat rowHeight;

@property (nonatomic,weak) id<WSPropertyFormItemDelegate> delegate;

@property (nonatomic) BOOL selected;

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// A base class for editing model objects attributes. Adds functionality onto WSFormItem
// to validate and edit
//
@interface WSPropertyFormItem : WSFormItem

// Default initializer
//
- (instancetype)initWithModel:(id)model
                    attribute:(NSString *)attribute;

+ (instancetype)formWithModel:(id)model
                    attribute:(NSString *)attribute;

- (instancetype)initWithTitle:(NSString *)title
                        model:(id)model
                    attribute:(NSString *)attribute;

// Get a string representation of an attribute. Used by subclass to get textual
// representation of NSNumbers and primitives
//
- (NSString *)attributeAsString:(NSString *)attribute;

// Sets the attribute for the items models objects
//
- (void)setValue:(id)value forAttribute:(NSString *)attribute;

// A title/header for the form item. Will be displayed in different ways depending
// on the underlying cell type
//
@property (nonatomic) NSString *title;

// The object whose properties are being edited
//
@property (nonatomic,readonly) id model;

// The model object attribute that is being displayed/edited
//
@property (nonatomic,readonly) NSString *attribute;

// A flag indicating whether the cell should accept input - Default is YES
//
@property (nonatomic) BOOL editable;

// A flag for required fields. If this is set then an asterik will be added
// before the field name
//
@property (nonatomic) BOOL isRequired;

// Optional. If specified this will limit the number of decimal place when the
// attribute value is displayeds
//
@property (nonatomic) NSUInteger decimalPrecision;

@end
