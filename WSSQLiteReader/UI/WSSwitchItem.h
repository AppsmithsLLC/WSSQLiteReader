//
//  WSSwitchItem.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import "WSPropertyFormItem.h"

@interface WSSwitchItem : WSPropertyFormItem <WSPropertyFormItemDelegate>

// A passthrough to the underlying cells UISwitch on property
//
@property (nonatomic) BOOL isOn;

@end
