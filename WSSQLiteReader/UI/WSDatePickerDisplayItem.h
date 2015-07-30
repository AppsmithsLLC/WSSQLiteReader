//
//  WSDatePickerDisplayItem.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import "WSPropertyFormItem.h"

@interface WSDatePickerDisplayItem : WSPropertyFormItem <WSPropertyFormItemDelegate>

// The date picker mode used for the data picker. This also dictates how the date is formatted
//
@property (nonatomic) UIDatePickerMode mode;

@end
