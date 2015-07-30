//
//  WSDatePickerDisplayItem.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import "WSDatePickerDisplayItem.h"
#import "WSTextFieldTableViewCell.h"
#import "WSDatePickerAlertController.h"
#import "WSAppSettings.h"

@interface WSDatePickerDisplayItem()<WSTextFieldTableViewCellDelegate>
{
    WSTextFieldTableViewCell *_tableViewCell;
}

@end

@implementation WSDatePickerDisplayItem

- (instancetype)initWithTitle:(NSString *)title model:(id)model attribute:(NSString *)attribute
{
    self = [super initWithTitle:title model:model attribute:attribute];
    if (self) {
        
        [model addObserver:self forKeyPath:attribute options:0 context:nil];
    }
    return self;
}

- (void)dealloc
{
    [self.model removeObserver:self forKeyPath:self.attribute];
}

-(UITableViewCell *)tableViewCell
{
    if (_tableViewCell){
        return _tableViewCell;
    }
    
    _tableViewCell = [[[NSBundle mainBundle] loadNibNamed:@"WSTextFieldTableViewCell" owner:self options:nil] firstObject];
    _tableViewCell.delegate = self;
    [_tableViewCell.textField setEnabled:NO];
    
    _tableViewCell.placeholderLabel.text =[NSString stringWithFormat:@"%@:", self.title];
    id value = [self.model valueForKeyPath:self.attribute];
    
    if ([value isKindOfClass:[NSDate class]]){
        _tableViewCell.textField.text = [NSDateFormatter localizedStringFromDate:value
                                                                       dateStyle:NSDateFormatterShortStyle
                                                                       timeStyle:NSDateFormatterNoStyle];
    }
    
    [_tableViewCell animateLabel];
    
    return _tableViewCell;
}

- (CGFloat)rowHeight
{
    return kHeightForStandardRow;
}

- (void)setSelected:(BOOL)selected
{
    id date = [self.model valueForKeyPath:self.attribute];
    
    if ([self.delegate respondsToSelector:@selector(presentViewController:forItem:)]) {
        WSDatePickerAlertController *datePicker = [[WSDatePickerAlertController alloc] initWithDate:date mode:self.mode andButtonSender:_tableViewCell];
        [datePicker setCompletionBlock:^(NSDate *date) {
            [self setValue:date forAttribute:self.attribute];
        }];
        [self.delegate presentViewController:datePicker forItem:self];
    }
}

- (void)textViewCellSelected:(WSTextFieldTableViewCell *)cell
{
    [self setSelected:YES];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    id value = [self.model valueForKeyPath:self.attribute];
    _tableViewCell.textField.text = [NSDateFormatter localizedStringFromDate:value
                                                                   dateStyle:NSDateFormatterShortStyle
                                                                   timeStyle:NSDateFormatterShortStyle];
    [_tableViewCell animateLabel];
}

@end
