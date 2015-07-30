//
//  WSDatePickerItem.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import "WSPropertyFormItem.h"

@interface WSDatePickerItem : WSPropertyFormItem <WSPropertyFormItemDelegate>

@property (nonatomic) UIDatePickerMode mode;

@end
