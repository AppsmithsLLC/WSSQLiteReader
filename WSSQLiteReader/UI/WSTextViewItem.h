//
//  WSTextViewItem.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import "WSPropertyFormItem.h"

@interface WSTextViewItem : WSPropertyFormItem <WSPropertyFormItemDelegate>

// Default initializer - no title is displayed in the notes field
//
- (instancetype)initWithModel:(id)model attribute:(NSString *)attribute;

@property (nonatomic) UIKeyboardType keyboard;

@end
