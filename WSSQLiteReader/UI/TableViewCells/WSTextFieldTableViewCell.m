//
//  WSTextFieldTableViewCell.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import "WSTextFieldTableViewCell.h"
#import "WSAppSettings.h"

const CGFloat cellAnimationDuration = .25f;
const CGFloat cellAnimationSpacing = 0;

@interface WSTextFieldTableViewCell()<UITextFieldDelegate>

@property BOOL labelIsSmall;

// UI Outlets redefined as readwrite internally
//
@property (nonatomic,weak,readwrite) IBOutlet UILabel* placeholderLabel;
@property (nonatomic,weak,readwrite) IBOutlet UITextField* textField;
@property (nonatomic,weak,readwrite) IBOutlet UILabel *unitsLabel;
@property (nonatomic,weak,readwrite) IBOutlet UIButton *unitsButton;
@property (nonatomic,weak,readwrite) IBOutlet UIImageView *accessoryImageView;

@property (nonatomic) NSCharacterSet *invertedCleanCharacterSet;

@end

@implementation WSTextFieldTableViewCell

- (void)awakeFromNib
{
    self.textField.delegate = self;
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setFirstResponder)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
    
    self.textField.textColor = [WSAppSettings sharedSettings].theme.textColor;
    self.textField.backgroundColor = [WSAppSettings sharedSettings].theme.backgroundColor;
    [self.textField setReturnKeyType:UIReturnKeyDone];
    
    [self.textField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.textField addObserver:self
                     forKeyPath:NSStringFromSelector(@selector(text))
                        options:(NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew)
                        context:nil];
    
    self.inputType = self.inputType;
    
    self.placeholderLabel.textColor = [WSAppSettings sharedSettings].theme.placeholderTextColor;
    self.unitsLabel.textColor = [WSAppSettings sharedSettings].theme.textColor;
}

- (void)dealloc
{
    [self.textField removeObserver:self forKeyPath:NSStringFromSelector(@selector(text))];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    [self animateLabel];
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    self.inputType = WSTextFieldTableViewCellInputTypeText;
}

- (void)setInputType:(WSTextFieldTableViewCellInputType)inputType
{
    _inputType = inputType;
    
    if (_inputType == WSTextFieldTableViewCellInputTypeText) {
        
        self.invertedCleanCharacterSet = nil;
        self.numberFormatter = nil;
        
        self.textField.keyboardType = UIKeyboardTypeAlphabet;
        self.textField.returnKeyType = UIReturnKeyDone;
    } else if(_inputType == WSTextFieldTableViewCellInputTypeInteger){
        
        self.invertedCleanCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        
        self.numberFormatter = [[NSNumberFormatter alloc] init];
        self.numberFormatter.numberStyle = NSNumberFormatterNoStyle;
        self.numberFormatter.maximumFractionDigits = 0;
        self.numberFormatter.usesGroupingSeparator = YES;

        self.textField.keyboardType = UIKeyboardTypeNumberPad;
        
    } else if (_inputType == WSTextFieldTableViewCellInputTypeDecimal){

        self.invertedCleanCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
        self.numberFormatter = [[NSNumberFormatter alloc] init];
        self.numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        self.numberFormatter.usesGroupingSeparator = YES;

        self.textField.keyboardType = UIKeyboardTypeDecimalPad;
    } else {
        NSAssert(NO, @"Internal inconsitency. Invalid WSTextFieldTableViewCellInputType");
    }
}

- (void)textDidChange:(UITextField *)textField
{
    if([self.delegate respondsToSelector:@selector(textViewCell:textDidChange:)])
    {
        [self.delegate textViewCell:self textDidChange:textField.text];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(textViewCellShouldBeginEditing:)]) {
        return [self.delegate textViewCellShouldBeginEditing:self];
    } else {
        return YES;
    }
}

- (NSString *)cleanedTextForEditing
{
    // If we have a number formatter than we need to run that text through the number formatter
    // to clear out any formatting characters. When editing the user should have
    // a nonformatted numerical value to work with
    //
    NSString *cleanedText = self.textField.text;
    
    if (self.numberFormatter) {
        
        // Strip the text of all non-numeric characters other than decimal point
        //
        cleanedText = [[cleanedText componentsSeparatedByCharactersInSet:self.invertedCleanCharacterSet] componentsJoinedByString:@""];
        
        NSNumber *number = [self.numberFormatter numberFromString:cleanedText];
        if (number == nil || number == 0){
            cleanedText = @"";
        } else {
            cleanedText = [number stringValue];
        }
    }
    
    return cleanedText;
}

- (NSString *)formattedTextForDisplay
{
    // When the text field has finished editing, if we have a number formatter
    // we want to run the text through it to make sure that we have a formatted
    // number displayed to the user
    //
    NSString *cleanedText = self.textField.text;
    if (self.numberFormatter) {
        
        // Strip the text of all non-numeric characters other than decimal point
        //
        cleanedText = [[cleanedText componentsSeparatedByCharactersInSet:self.invertedCleanCharacterSet] componentsJoinedByString:@""];
        
        NSNumber *number = [self.numberFormatter numberFromString:cleanedText];
        if (number == nil || number == 0){
            cleanedText = @"";
        } else {
            cleanedText = [self.numberFormatter stringFromNumber:number];
        }
    }
    
    return cleanedText;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.textField.text = [self cleanedTextForEditing];
    
    if([self.delegate respondsToSelector:@selector(textViewCell:textDidStartEditing:)])
    {
        [self.delegate textViewCell:self textDidStartEditing:self.textField.text];
    }
    
    if (self.labelIsSmall == YES)
    {
        return;
    }
    
    [self shrinkLabel];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.textField.text = [self formattedTextForDisplay];
    
    if ([self.textField.text length] != 0)
    {
        return;
    }
    
    if (self.labelIsSmall == YES)
    {
        [self enlargeLabel];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)animateLabel
{
    if (([self.textField.text length] > 0 && self.labelIsSmall == YES)
        || ([self.textField.text length] == 0 && self.labelIsSmall == NO))
    {
        //Label is correct
        return;
    }
    
    if ([self.textField.text length] == 0)
    {
        [self enlargeLabel];
    }
    else
    {
        [self shrinkLabel];
    }
}

-(void)shrinkLabel
{
    if (self.unitsLabel.text.length > 0) {
        [self.unitsLabel setHidden:NO];
    } else if (self.unitsButton.titleLabel.text.length > 0){
        [self.unitsButton setHidden:NO];
    }
    
    
    self.placeholderLabel.transform = CGAffineTransformMakeScale(1, 1);
    self.placeholderLabel.frame = CGRectMake(31, 16, 279, 21);
    self.placeholderLabel.textColor = [WSAppSettings sharedSettings].theme.placeholderTextColor;
    
    if (!self.performAnimation)
    {
        self.placeholderLabel.transform = CGAffineTransformMakeScale(.45, .45);
        self.placeholderLabel.frame = CGRectMake(21, 5, 279, 21);
        self.placeholderLabel.textColor = [WSAppSettings sharedSettings].theme.textColor;
        self.labelIsSmall = YES;
        self.performAnimation = YES;
        return;
    }
    
    [UIView animateWithDuration:cellAnimationDuration delay:cellAnimationSpacing usingSpringWithDamping:.9 initialSpringVelocity:.5 options:0 animations:^{
        self.placeholderLabel.transform = CGAffineTransformMakeScale(.45, .45);
        self.placeholderLabel.frame = CGRectMake(21, 5, 279, 21);
        self.placeholderLabel.textColor = [WSAppSettings sharedSettings].theme.textColor;
    }
                     completion:^(BOOL finished)
     {
         self.labelIsSmall = YES;
     }];
}

-(void)enlargeLabel
{
    // Always hide units stuff when enlarged
    //
    [self.unitsButton setHidden:YES];
    [self.unitsLabel setHidden:YES];
    
    self.placeholderLabel.transform = CGAffineTransformMakeScale(.45, .45);
    self.placeholderLabel.frame = CGRectMake(11, 5, 279, 21);
    self.placeholderLabel.textColor = [WSAppSettings sharedSettings].theme.textColor;

    
    if (!self.performAnimation)
    {
        self.placeholderLabel.textColor = [WSAppSettings sharedSettings].theme.placeholderTextColor;
        self.placeholderLabel.transform = CGAffineTransformMakeScale(1, 1);
        self.placeholderLabel.frame = CGRectMake(21, 16, 279, 21);
        self.labelIsSmall = NO;
        self.performAnimation = YES;
        return;
    }
    
    [UIView animateWithDuration:cellAnimationDuration delay:cellAnimationSpacing usingSpringWithDamping:.9 initialSpringVelocity:.5 options:0 animations:^
     {
         self.placeholderLabel.transform = CGAffineTransformMakeScale(1, 1);
         self.placeholderLabel.frame = CGRectMake(21, 16, 279, 21);
     }
                     completion:^(BOOL finished)
     {
         self.placeholderLabel.textColor = [WSAppSettings sharedSettings].theme.placeholderTextColor;
         self.labelIsSmall = NO;
     }];
}

-(void)setFirstResponder
{
    if ([self.delegate respondsToSelector:@selector(textViewCellSelected:)]) {
        [self.delegate textViewCellSelected:self];
    }
    
    [self.textField becomeFirstResponder];
}

// An action method that is fired when the units button is clicked. This will
// call back to the buttons delegate to have it respond to that click event. In most
// cases this will result in a popover being displayed on top of the corresponding table view
//
- (IBAction)untisButtonSelected:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(textViewCell:didSelectUnitsButton:)]) {
        [self.delegate textViewCell:self didSelectUnitsButton:sender];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.textField && [keyPath isEqualToString:NSStringFromSelector(@selector(text))]) {
        
        if (![self.textField isFirstResponder]) {
            
            if (self.numberFormatter)
            {
                NSString *displayText = [self formattedTextForDisplay];
                if ([self.textField.text isEqualToString:displayText]) {
                    return;
                }
                
                self.textField.text = [self formattedTextForDisplay];
            }
            
            [self animateLabel];
        }
    }
}

@end
