//
//  WSFormSection.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import <UIKit/UIKit.h>

@class WSFormSection;
@class WSFormSectionHeaderView;
@class WSPropertyFormItem;


@protocol WSFormSectionDelegate <NSObject>

- (void)formSectionDidChangeCollapsedState:(WSFormSection *)section;

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// A WSFormSection equates to a UITableViewSection and is a container object
// for individual form items
//
@interface WSFormSection : NSObject

+ (instancetype)sectionWithTitle:(NSString *)title;
- (instancetype)initWithTitle:(NSString *)title;

-(WSFormSectionHeaderView *)headerView:(UITableView *)tableView;

@property (nonatomic,weak) id<WSFormSectionDelegate> delegate;

// The title for the section
//
@property (nonatomic) NSString *title;

// The row height for the section
//
@property (nonatomic) CGFloat height;

// "Accordion" section support - Defaults to YES
//
@property (nonatomic, getter=isCollapsible) BOOL collapsible;

// Flag indicating whether the section is collapsed
//
@property (nonatomic, getter=isCollapsed) BOOL collapsed;

// Defaults to yes. When set to no, the section header/title will not be displayed
//
@property (nonatomic) BOOL showSectionHeader;

// The block that is executed when the section headers add button is clicked
//
@property (nonatomic,strong) void (^addBlock)();

// The rows/items for the sections - array of WSPropertyFormItem and derivatives
// TODO It's bad form to expose this property publicly. I should probably create access
// methods or a wrapper class to hide this from the consumer.
//
@property (nonatomic,readonly) NSMutableArray *rows;

@end
