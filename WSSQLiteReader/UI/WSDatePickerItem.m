//
//  WSDatePickerItem.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import "WSDatePickerItem.h"
#import "WSDatePickerTableViewCell.h"
#import "WSAppSettings.h"

@interface WSDatePickerItem()<WSDatePickerTableViewCellDelegate>
{
    WSDatePickerTableViewCell *_tableViewCell;
}

@end

@implementation WSDatePickerItem

-(UITableViewCell *)tableViewCell
{
    if (_tableViewCell){
        return _tableViewCell;
    }
    
    NSString *nibName = @"WSDatePickerTableViewCell";
    _tableViewCell = [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] firstObject];
    
    _tableViewCell.datePickerOutlet.datePickerMode = self.mode;
    _tableViewCell.delegate = self;
    
    id value = [self.model valueForKeyPath:self.attribute];
    if ([value isKindOfClass:[NSDate class]]){
        _tableViewCell.datePickerOutlet.date = value;
    }
    
    return _tableViewCell;
}

- (CGFloat)rowHeight
{
    return kHeightForStandardRow;
}

-(void)datePickerViewCell:(WSDatePickerTableViewCell *)cell dateDidChange:(NSDate *)newDate
{
    [self setValue:newDate forAttribute:self.attribute];
}

@end
