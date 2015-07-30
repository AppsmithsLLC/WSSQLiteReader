//
//  WSTextViewItem.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import "WSTextViewItem.h"
#import "WSTextViewTableViewCell.h"
#import "WSAppSettings.h"

@interface WSTextViewItem() <WSTextViewTableViewCellDelegate>
{
    WSTextViewTableViewCell *_tableViewCell;
}

@end

@implementation WSTextViewItem

- (instancetype)initWithModel:(id)model attribute:(NSString *)attribute
{
    self = [super initWithModel:model attribute:attribute];
    if (self) {
        
    }
    return self;
}

- (UITableViewCell *)tableViewCell
{
    if (_tableViewCell ) {
        _tableViewCell.textViewLabel.text = [super title];
        return _tableViewCell;
    }
    
    _tableViewCell = [[[NSBundle mainBundle] loadNibNamed:@"WSTextViewTableViewCell" owner:self options:nil] firstObject];
    _tableViewCell.delegate = self;
    _tableViewCell.textView.keyboardType = self.keyboard;
    
    NSString *value = [self attributeAsString:self.attribute];
    if (value) {
        _tableViewCell.textView.text = value;
    }
    
    return _tableViewCell;
}

- (CGFloat)rowHeight
{
    return kHeightForTextViewRow;
}

- (void)wsTextViewCell:(WSTextViewTableViewCell*)cell textDidChange:(NSString*)newText
{
    if (self.attribute) {
        [self setValue:newText forAttribute:self.attribute];
    }
}

- (void)wsTextViewCell:(WSTextViewTableViewCell*)cell textDidBeginEditing:(NSString*)newText
{
    [self.delegate didSelectCellForItem:self];
}
@end
