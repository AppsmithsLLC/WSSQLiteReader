//
//  WSBaseForm.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import <UIKit/UIKit.h>
#import "WSPropertyFormItem.h"
#import "WSFormSection.h"

@class WSBaseForm;

@protocol WSBaseFormDelegate <NSObject>

- (void)willDismissForm:(WSBaseForm *)form;

@end

// A baseclass for data forms. Acts as a delegate/dataSource for a UITableView
// and manages the creation of cell content
//
@interface WSBaseForm : UITableViewController<WSFormSectionDelegate>
{
    @protected
    
    NSArray *_formDataSource;
}

// The datasource that feeds the table view - a collection of WSFormSections
//
@property (nonatomic) NSArray *formDataSource;

@property (nonatomic) id<WSBaseFormDelegate> formDelegate;

// Return the index path of the item in the formDatasource. If the item does not
// exist, returns NSNotFound
//
- (NSIndexPath *)indexOfItem:(WSPropertyFormItem *)item;

// Removes an item from the form data source
//
- (void)removeFormItemAtIndexPath:(NSIndexPath *)indexPath;

- (WSPropertyFormItem *)itemAtIndexPath:(NSIndexPath *)indexPath;

// Doesn't actually dismiss the form but triggers the sequence of events that will
// by calling back to the form's delegate
//
- (void)dismiss;

@end
