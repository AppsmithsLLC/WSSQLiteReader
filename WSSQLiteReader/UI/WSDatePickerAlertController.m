//
//  WSDatePickerAlertController.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import "WSDatePickerAlertController.h"

@interface WSDatePickerAlertController ()

@property (nonatomic,readonly) NSDate *initialDate;
@property (nonatomic,readonly) UIDatePickerMode mode;

@end

@implementation WSDatePickerAlertController

- (instancetype)initWithDate:(NSDate *)date mode:(UIDatePickerMode)mode andButtonSender:(UIView*)sender
{
    self = [WSDatePickerAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if (self) {
        _mode = mode;
        _initialDate = (date) ? date : [NSDate date];
        self.popoverPresentationController.sourceView = sender;
        self.popoverPresentationController.sourceRect = sender.bounds;
    }
    return self;
}

- (instancetype)initWithDate:(NSDate *)date mode:(UIDatePickerMode)mode andBarButtonItemSender:(UIBarButtonItem *)sender
{
    self = [WSDatePickerAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if (self) {
        _mode = mode;
        _initialDate = (date) ? date : [NSDate date];
        self.popoverPresentationController.barButtonItem = sender;
    }
    return self;
}

- (void)viewDidLoad
{
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.frame = CGRectMake(0, 0, 320, 162);
    [datePicker setTimeZone:[NSTimeZone localTimeZone]];
    [datePicker setDatePickerMode:self.mode];
    [datePicker setDate:self.initialDate];
    [datePicker setTimeZone:[NSTimeZone localTimeZone]];
    
    [self.view addSubview:datePicker];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:225]];
    
    UIAlertAction* done = [UIAlertAction actionWithTitle:@"Done"
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction *action)    {
                                                     if (self.completionBlock) {
                                                         self.completionBlock(datePicker.date);
                                                     }
                                                 }];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *action) {
                                                       
                                                       [self dismissViewControllerAnimated:YES completion:nil];
                                                       if (self.cancelBlock) {
                                                           self.cancelBlock();
                                                       }
                                                   }];

    [self addAction:done];
    [self addAction:cancel];
    
}

@end
