//
//  WSDatePickerTableViewCell.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import "WSDatePickerTableViewCell.h"

@implementation WSDatePickerTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)datePickerValueChanged:(id)sender
{
    NSDate* newDate = [self.datePickerOutlet date];
    if([self.delegate respondsToSelector:@selector(datePickerViewCell:dateDidChange:)])
    {
        [self.delegate datePickerViewCell:self dateDidChange:newDate];
    }
}

@end
