//
//  WSBaseForm.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import "WSBaseForm.h"
#import "WSPropertyFormItem.h"
#import "WSAppSettings.h"
#import "WSFormSectionHeaderView.h"
#import "UITableViewCell+WSCellStyle.h"

@interface WSBaseForm ()<WSPropertyFormItemDelegate, UIPopoverPresentationControllerDelegate>

@property UIPopoverPresentationController* popover;

@end

@implementation WSBaseForm

-(instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

-(void)viewDidLoad
{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([WSFormSectionHeaderView class]) bundle:nil];
    [self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:WSFormSectionHeaderReuseIdentifier];
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.backgroundColor = [WSAppSettings sharedSettings].theme.backgroundColor;
    
    /* 
     In case this is the root view controller, I don't want to show my back button.
     */
    if ([self presentingViewController])
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel)];
    }
    [self setNeedsStatusBarAppearanceUpdate];
}

-(void)onCancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray *)formDataSource
{
    return _formDataSource;
}

-(void)setFormDataSource:(NSArray *)dataSource
{
    _formDataSource = dataSource;
    [self.tableView reloadData];
}

- (NSIndexPath *)indexOfItem:(WSPropertyFormItem *)item
{
    for (NSUInteger i=0; i < self.formDataSource.count; i++){
        WSFormSection *section = [self.formDataSource objectAtIndex:i];
        for (NSUInteger j=0; j <section.rows.count; j++){
            WSPropertyFormItem *formItem = [section.rows objectAtIndex:j];
            if (formItem == item){
                return [NSIndexPath indexPathForRow:j inSection:i];
            }
        }
    }
    
    return nil;
}

- (void)removeFormItemAtIndexPath:(NSIndexPath *)indexPath
{
    WSFormSection *section = [_formDataSource objectAtIndex:indexPath.section];
    [section.rows removeObjectAtIndex:indexPath.row];
}

- (WSPropertyFormItem *)itemAtIndexPath:(NSIndexPath *)indexPath
{
    WSFormSection *section = [self.formDataSource objectAtIndex:indexPath.section];
    return [section.rows objectAtIndex:indexPath.row];
}

#pragma mark - UITableViewDelegate/UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    WSFormSection *formSection = [self.formDataSource objectAtIndex:section];
    return formSection.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WSFormSection *formSection = [self.formDataSource objectAtIndex:section];
    WSFormSectionHeaderView *headerView = [formSection headerView:tableView];
    return headerView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.formDataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WSFormSection *formSection = [self.formDataSource objectAtIndex:section];
    return (formSection.collapsed) ? 0 : formSection.rows.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Generate a cell from our dataSource
    //
    WSPropertyFormItem *item = [self itemAtIndexPath:indexPath];
    item.delegate = self;
    
    UITableViewCell *cell = item.tableViewCell;
    
    [cell styleCellWithSettings];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSPropertyFormItem *item = [self itemAtIndexPath:indexPath];
    return item.rowHeight;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // A row was selected - pass that information down to the item
    //
    WSFormSection *section = [self.formDataSource objectAtIndex:indexPath.section];
    WSPropertyFormItem *item = [section.rows objectAtIndex:indexPath.row];
    [item setSelected:YES];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // A row was deselected - pass that information down the item
    //
    WSFormSection *section = [self.formDataSource objectAtIndex:indexPath.section];
    WSPropertyFormItem *item = [section.rows objectAtIndex:indexPath.row];
    [item setSelected:NO];
    [item.tableViewCell endEditing:YES];
}

#pragma mark - WSFormSectionDelegate
-(void)formSectionDidChangeCollapsedState:(WSFormSection *)section
{
    if (section.collapsed) {
        // Animate rows out
        //
        [self collapseSection:section];
        
    } else {
        // Animate rows in
        //
        [self expandSection:section];
        NSUInteger sectionIndex = [self.formDataSource indexOfObject:section];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:NSNotFound inSection:sectionIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

-(void)collapseSection:(WSFormSection *)section
{
    NSUInteger sectionIndex = [self.formDataSource indexOfObject:section];
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSUInteger i = 0; i < section.rows.count; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:sectionIndex]];
    }
    
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)expandSection:(WSFormSection *)section
{
    NSUInteger sectionIndex = [self.formDataSource indexOfObject:section];
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSUInteger i = 0; i < section.rows.count; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:sectionIndex]];
    }
    
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - WSPropertyFormItemDelegate
// Notifies the delegate to push a new view controller onto the stack
//
-(void)pushViewController:(UIViewController *)controller
                  forItem:(WSPropertyFormItem *)item
{
    [self.navigationController pushViewController:controller animated:YES];
}

// Notifies the delegate to display a new content popover positioned at the
// input view (sender)
//
-(void)showPopupWithController:(UIViewController *)controller
                       forItem:(WSPropertyFormItem *)item
                      fromView:(UIView *)sender
{
    // TODO: Set up popover display
    //
    self.popover = controller.popoverPresentationController;
    self.popover.delegate = self;
    self.popover.sourceView = sender;
    
    // Adjust the display postion. We're essentially forcing it to show from
    // the top left corner of the sender
    //
    CGRect sourceRect = sender.frame;
    sourceRect.origin = CGPointMake(30, sender.frame.origin.y - sourceRect.size.height/2);
    sourceRect.size = CGSizeMake(10, 10);
    self.popover.sourceRect = sourceRect;
    
    self.popover.permittedArrowDirections = UIPopoverArrowDirectionDown;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)presentViewController:(UIViewController *)controller forItem:(WSPropertyFormItem *)item
{
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)dismissPopup
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didSelectCellForItem:(WSPropertyFormItem *)item
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:item.tableViewCell];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
}


-(void)showViewController:(UIViewController *)controller forItem:(WSFormItem *)item
{
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Actions Handlers
-(void)dismiss
{
    if ([self.formDelegate respondsToSelector:@selector(willDismissForm:)])
    {
        [self.formDelegate willDismissForm:self];
    }
}

#pragma mark - PopoverPrensentationDelegate
-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

@end

