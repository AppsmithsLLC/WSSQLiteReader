//
//  WSDatePickerAlertController.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import <UIKit/UIKit.h>

@interface WSDatePickerAlertController : UIAlertController

// Default initializer. If date is nil, the current date/time will be used
//
- (instancetype)initWithDate:(NSDate *)date mode:(UIDatePickerMode)mode andButtonSender:(UIView*)sender;
- (instancetype)initWithDate:(NSDate *)date mode:(UIDatePickerMode)mode andBarButtonItemSender:(UIBarButtonItem*)sender;

// Called when the user selects a date and clicks the done button
//
@property (nonatomic,strong) void (^completionBlock)(NSDate *date);

// Optional: The controller will dismiss itself so this block gives the opportunity
// for calling classes to perform addtional actions
//
@property (nonatomic,strong) void (^cancelBlock)();

@end
