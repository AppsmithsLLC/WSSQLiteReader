//
//  WSTextFieldTableViewCell.h
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import <UIKit/UIKit.h>

@class WSTextFieldTableViewCell;

typedef enum : NSUInteger {
    WSTextFieldTableViewCellInputTypeText,
    WSTextFieldTableViewCellInputTypeDecimal,
    WSTextFieldTableViewCellInputTypeInteger
} WSTextFieldTableViewCellInputType;


@protocol WSTextFieldTableViewCellDelegate <NSObject>

@optional
- (BOOL)textViewCellShouldBeginEditing:(WSTextFieldTableViewCell*)cell;
- (void)textViewCell:(WSTextFieldTableViewCell*)cell textDidChange:(NSString*)newText;
- (void)textViewCell:(WSTextFieldTableViewCell*)cell textDidStartEditing:(NSString*)newText;

@optional

// Get rid of this
//
- (void)textViewCellSelected:(WSTextFieldTableViewCell *)cell;


// Replace with action on button
//
- (void)textViewCell:(WSTextFieldTableViewCell*)cell didSelectUnitsButton:(UIButton *)unitsButton;

@end

@interface WSTextFieldTableViewCell : UITableViewCell

@property (nonatomic, weak) id<WSTextFieldTableViewCellDelegate> delegate;

// A label displaying the title for the text field. This will grow or shrink
// depending on the editing state and content of the text input field
//
@property (nonatomic,weak,readonly) IBOutlet UILabel* placeholderLabel;

// The text input that the user edits
//
@property (nonatomic,weak,readonly) IBOutlet UITextField* textField;

// Hidden by default. This is an optional label that is displayed to the right
// of the text input
//
@property (nonatomic,weak,readonly) IBOutlet UILabel *unitsLabel;

// Hidden by default. This is an optional button that is displayed to the right
// of the text input.
//
@property (nonatomic,weak,readonly) IBOutlet UIButton *unitsButton;

// Hidden by default. An image that an be displayed just to the left of the standard
// UITableViewCell accessory view
//
@property (nonatomic,weak,readonly) IBOutlet UIImageView *accessoryImageView;

// A flag indicating whether the cell should perform animations when moving
// in between on/off editing states
//
@property (nonatomic) BOOL performAnimation;

// An optional number formatter. When a number formatter is set, the textField will
// be formatted as the fly. The number formatter will also remove non-numerical input
// ie. ',' when sending the input back view the delegate
//
@property (nonatomic) NSNumberFormatter *numberFormatter;

// Optional: Defaults to text input type per enum
// If a different input type is selected than this will do a number of things.
// First, it will change the text field keyboard input accordingly
// Second, it will set the numberFormatter property accordingly
//
@property (nonatomic) WSTextFieldTableViewCellInputType inputType;

// Forces an animation update. This will grow/shrink the placeholder (header)
// text depending on the state of the textField
//
-(void)animateLabel;

@end
