//
//  WSSwitchItem.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import "WSSwitchItem.h"
#import "WSToggleSwitchTableViewCell.h"
#import "WSAppSettings.h"

@interface WSSwitchItem()
{
    WSToggleSwitchTableViewCell *_tableViewCell;
}

@property (nonatomic,readonly) NSString *title;

@end

@implementation WSSwitchItem

- (instancetype)initWithTitle:(NSString *)title model:(id)model attribute:(NSString *)attribute
{
    self = [super initWithTitle:title model:model attribute:attribute];
    if (self) {
        
    }
    return self;
}

- (UITableViewCell *)tableViewCell
{
    if (_tableViewCell) {
        return _tableViewCell;
    }
    
    if (!_tableViewCell) {
        NSString *nibName = @"WSToggleSwitchTableViewCell";
        _tableViewCell = [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] firstObject];
    }
    
    // Configure cell
    _tableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [_tableViewCell.label setTextColor:[WSAppSettings sharedSettings].theme.textColor];
    [_tableViewCell.label setText:[NSString stringWithFormat:@"%@:",self.title]];
    
    // Before setting up toggle switch event handling, check for an initial value
    // and turn the switch on/off accordingly
    //
    if (!self.attribute) {
        [_tableViewCell.toggleSwitch setOn:NO];
    } else {
        NSString *attributeValue = [self attributeAsString:self.attribute];
        if (!attributeValue || [attributeValue isEqualToString:@"0"]) {
            [_tableViewCell.toggleSwitch setOn:NO];
        } else {
            [_tableViewCell.toggleSwitch setOn:YES];
        }
    }
    
    [_tableViewCell.toggleSwitch addTarget:self
                                    action:@selector(didToggleAttribute:)
                          forControlEvents:UIControlEventValueChanged];
    
    return _tableViewCell;
}

- (CGFloat)rowHeight
{
    return kHeightForStandardRow;
}

- (BOOL)isOn
{
    return _tableViewCell.toggleSwitch.isOn;
}

- (void)setIsOn:(BOOL)isOn
{
    WSToggleSwitchTableViewCell *cell = (WSToggleSwitchTableViewCell *)self.tableViewCell;
    [cell.toggleSwitch setOn:isOn animated:YES];
}

#pragma mark - UI Actions

- (IBAction)didToggleAttribute:(UISwitch *)sender
{
    [self setValue:[NSNumber numberWithBool:sender.on] forAttribute:self.attribute];
}

@end

