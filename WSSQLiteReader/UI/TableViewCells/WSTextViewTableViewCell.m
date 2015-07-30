//
//  WSTextViewTableViewCell.m
//  WSSQLiteReader
//
//  Created by William Smith on 7/24/15.
//

#import "WSTextViewTableViewCell.h"
#import "WSAppSettings.h"

@implementation WSTextViewTableViewCell

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.textView.delegate = self;
    self.textView.textColor = [WSAppSettings sharedSettings].theme.textColor;
    self.textView.tintColor = [WSAppSettings sharedSettings].theme.textColor;
    self.textView.backgroundColor = [WSAppSettings sharedSettings].theme.backgroundColor;
    self.textViewLabel.textColor = [WSAppSettings sharedSettings].theme.textColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([self.delegate respondsToSelector:@selector(wsTextViewCell:textDidBeginEditing:)])
    {
        [self.delegate wsTextViewCell:self textDidBeginEditing:textView.text];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString* newText = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if([self.delegate respondsToSelector:@selector(wsTextViewCell:textDidChange:)])
    {
        [self.delegate wsTextViewCell:self textDidChange:newText];
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSString* text = textView.text;
    if([self.delegate respondsToSelector:@selector(wsTextViewCell:textDidChange:)])
    {
        [self.delegate wsTextViewCell:self textDidChange:text];
    }
}

@end
