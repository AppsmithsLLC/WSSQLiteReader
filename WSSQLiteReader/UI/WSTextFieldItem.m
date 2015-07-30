//
//  WSTextFieldItem.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import "WSTextFieldItem.h"
#import "WSAppSettings.h"

@interface WSTextFieldItem()<WSTextFieldTableViewCellDelegate>
{
    WSTextFieldTableViewCell *_tableViewCell;
}

@end

@implementation WSTextFieldItem

- (instancetype)initWithTitle:(NSString *)title
                        model:(id)model
                    attribute:(NSString *)attribute
{
    self = [super initWithTitle:title model:model attribute:attribute];
    if (self) {
        
        // Default input type is decimal
        //
        _inputType = WSTextFieldTableViewCellInputTypeDecimal;
        
        _readOnly = YES;
        
        if (attribute) {
            [model addObserver:self forKeyPath:attribute options:0 context:nil];
        }
    }
    return self;
}


- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content
{
    self = [super initWithTitle:title model:nil attribute:nil];
    if (self) {
        _content = content;
        _readOnly = YES;
    }
    return self;
}

- (void)dealloc
{
    if (self.attribute) {
        [self.model removeObserver:self forKeyPath:self.attribute];
    }
}

- (void)setContent:(NSString *)content
{
    _content = content;
    
    _tableViewCell.textField.text = content;
}

- (void)setInputType:(WSTextFieldTableViewCellInputType)inputType
{
    _inputType = inputType;
    
    if (_tableViewCell) {
        _tableViewCell.inputType = _inputType;
    }
}

- (UITableViewCell *)tableViewCell
{
    if (_tableViewCell) {
        return _tableViewCell;
    }
    
    if (!_tableViewCell) {
        _tableViewCell = [[[NSBundle mainBundle] loadNibNamed:@"WSTextFieldTableViewCell" owner:self options:nil] firstObject];
        _tableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    _tableViewCell.delegate = self;
    
    // Check for static content first - If that has a value then we don't can short circuit most
    // of the logic below
    //
    if (self.content) {
        _tableViewCell.placeholderLabel.text = [NSString stringWithFormat:@"%@:", self.title];
        _tableViewCell.textField.text = self.content;
        return _tableViewCell;
    }
    
    _tableViewCell.inputType = self.inputType;
    
    // Add a flag to the title if the cell is required
    //
    if (self.isRequired) {
        _tableViewCell.placeholderLabel.text = [NSString stringWithFormat:@"* %@:",self.title];
    } else {
        _tableViewCell.placeholderLabel.text = [NSString stringWithFormat:@"%@:", self.title];
    }
    
    // Setup initial value for the main attribute
    //
    //
    NSString *value;
    if (self.attribute) {
        value = [self attributeAsString:self.attribute];
    }
    
    if (value) {
        _tableViewCell.textField.text = value;
    } else {
        _tableViewCell.textField.text = self.placeholder;
    }
    
    
    return _tableViewCell;
}

- (CGFloat)rowHeight
{
    return kHeightForStandardRow;
}

#pragma mark TextViewCell delegate

- (BOOL)textViewCellShouldBeginEditing:(WSTextFieldTableViewCell *)cell
{
    if (self.isReadOnly){
        [self.delegate didSelectCellForItem:self];
    }
    
    return !self.isReadOnly;
}

- (void)textViewCell:(WSTextFieldTableViewCell*)cell textDidChange:(NSString*)newText
{
    [self setValue:newText forAttribute:self.attribute];
}

- (void)textViewCell:(WSTextFieldTableViewCell*)cell textDidStartEditing:(NSString*)newText
{
    // Call back to something to let them know the row was selected
    // Need to research why we need this
    //
    if ([self.delegate respondsToSelector:@selector(didSelectCellForItem:)]) {
        [self.delegate didSelectCellForItem:self];
    }
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:self.attribute]){
        
        NSString *value = [self attributeAsString:self.attribute];
        
        if (_tableViewCell.textField.isEditing) {
            return;
        }
        
        // Avoid a recursive text edit. If the cells text field is different from this
        // new value we should update it otherwise we should leave it alone. If the underlying
        // attribute is updated via KVO this method will get called and without this
        // check it would result in duplicate character input
        //
        if ([_tableViewCell.textField.text isEqualToString:value]) {
            return;
        }
        
        _tableViewCell.textField.text = value;
        
        // If the cell's textfield is first responder then we should avoid any animation
        // because it's already in the editing process. For other cells we may want
        // to animate the label in/out
        //
        if (!_tableViewCell.textField.isFirstResponder) {
            [_tableViewCell animateLabel];
        }
    }
}

@end

