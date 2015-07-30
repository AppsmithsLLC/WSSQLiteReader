//
//  WSDatePickerTableViewCell.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import <UIKit/UIKit.h>

@class WSDatePickerTableViewCell;

@protocol WSDatePickerTableViewCellDelegate <NSObject>

- (void)datePickerViewCell:(WSDatePickerTableViewCell*)cell dateDidChange:(NSDate*)newDate;

@end

@interface WSDatePickerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerOutlet;
- (IBAction)datePickerValueChanged:(id)sender;

//Delegate
@property (nonatomic,weak) id<WSDatePickerTableViewCellDelegate> delegate;

@end
